provider "oci" {
  config_file_profile = var.oci_cli_profile
}

# Automatically fetch tenancy information using CLI profile
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = "ignored" # Required, but ignored with CLI profile
}

# Get all available Oracle services in the region
data "oci_core_services" "all_services" {}

# Get all regions and identify the home region
data "oci_identity_regions" "regions" {}


# Get all availability domains in this compartment
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

# Get the latest image for your node pool shape
data "oci_core_images" "node_pool_images" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.node_pool_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

output "debug_home_region_key" {
  value = data.oci_identity_tenancy.tenancy.home_region_key
}

output "debug_region_keys" {
  value = [for r in data.oci_identity_regions.regions.regions : r.key]
}

output "debug_region_names" {
  value = [for r in data.oci_identity_regions.regions.regions : r.name]
}

output "debug_region_pairs" {
  value = [
    for r in data.oci_identity_regions.regions.regions :
    "${r.key} => ${r.name}"
  ]
}

output "current_region_from_config" {
  description = "The OCI region being used (from the config file)"
  value       = data.oci_identity_regions.regions.regions[0].name
}

locals {
  current_region_map = {
    for r in data.oci_identity_regions.regions.regions : r.key => r.name
  }

  current_region = (
    data.oci_identity_tenancy.tenancy.home_region_key != null
    ? lookup(local.current_region_map, data.oci_identity_tenancy.tenancy.home_region_key, var.region)
    : var.region
  )

  dynamic_service_name = "All ${local.current_region} Services In Oracle Services Network"

  tenancy_ocid         = data.oci_identity_tenancy.tenancy.id
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[0].name
  node_pool_image_id   = data.oci_core_images.node_pool_images.images[0].id

  service_cidr = one([
    for s in data.oci_core_services.all_services.services : s.cidr_block
    if s.name == local.dynamic_service_name
  ])
}

# VCN module
module "vcn" {
  source                   = "./modules/vcn"
  compartment_id           = var.compartment_id
  vcn_display_name         = var.vcn_display_name
  vcn_dns_label            = var.vcn_dns_label
  vcn_cidr                 = var.vcn_cidr
  service_cidr             = local.service_cidr
  lb_subnet_cidr           = var.lb_subnet_cidr
  node_subnet_cidr         = var.node_subnet_cidr
  api_endpoint_subnet_cidr = var.api_endpoint_subnet_cidr
  freeform_tags            = var.freeform_tags
}

# OKE module
module "oke" {
  source = "./modules/oke"

  compartment_id              = var.compartment_id
  tenancy_id                  = data.oci_identity_tenancy.tenancy.id
  cluster_name                = var.cluster_name
  kubernetes_version          = var.kubernetes_version
  vcn_id                      = module.vcn.vcn_id
  api_endpoint_subnet_id      = module.vcn.kubernetes_api_endpoint_subnet_id
  lb_subnet_id                = module.vcn.service_lb_subnet_id
  node_subnet_id              = module.vcn.node_subnet_id
  node_pool_name              = var.node_pool_name
  node_pool_shape             = var.node_pool_shape
  availability_domain         = local.availability_domain
  node_pool_size              = var.node_pool_size
  node_pool_node_memory_in_gbs = var.node_pool_node_memory_in_gbs
  node_pool_node_ocpus        = var.node_pool_node_ocpus
  node_pool_image_id          = local.node_pool_image_id

  # Optional advanced network settings can go here
  # is_api_endpoint_public     = true
  # enable_kubernetes_dashboard = false
  # enable_tiller              = false
  # enable_pod_security_policy = false
  # pods_cidr                  = "10.244.0.0/16"
  # services_cidr              = "10.96.0.0/16"
}

# ADB module
module "adb_23ai" {
  source = "./modules/adb_23ai"

  compartment_id           = var.compartment_id
  db_name                  = var.adb_name
  display_name             = var.adb_display_name
  admin_password           = var.adb_admin_password
  cpu_core_count           = var.adb_cpu_core_count
  data_storage_size_in_tbs = var.adb_data_storage_size_in_tbs
  is_free_tier             = var.adb_is_free_tier
  license_model            = var.adb_license_model
  whitelisted_ips          = var.adb_whitelisted_ips
  customer_contact_email   = var.adb_customer_contact_email
  defined_tags             = var.adb_defined_tags
  # db_version             = var.adb_db_version (optional if defaulted)
}

# Vault module
module "vault" {
  source = "./modules/vault"

  compartment_id               = var.compartment_id
  vault_name                   = var.vault_name
  key_name                     = var.vault_key_name
  oke_nodes_dynamic_group_name = var.oke_dynamic_group_name
  policy_name                  = "${var.vault_name}-policy"
}

