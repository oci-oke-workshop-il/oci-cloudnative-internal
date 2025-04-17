variable "oci_cli_profile" {
  description = "The OCI CLI profile to use for authentication"
  type        = string
  default     = "DEFAULT"
}

variable "region" {
  description = "The OCI region to deploy resources"
  type        = string
}


variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

# VCN
variable "vcn_display_name" {
  description = "Display name for the VCN"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label for the VCN"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
}


# Subnets
variable "lb_subnet_cidr" {
  description = "Load balancer subnet CIDR"
  type        = string
}

variable "node_subnet_cidr" {
  description = "Node pool subnet CIDR"
  type        = string
}

variable "api_endpoint_subnet_cidr" {
  description = "Kubernetes API endpoint subnet CIDR"
  type        = string
}

variable "freeform_tags" {
  description = "Freeform tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# OKE
variable "cluster_name" {
  type        = string
  default     = "oke-workshop"
  description = "Name of the OKE cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the cluster"
}

variable "node_pool_name" {
  type        = string
  description = "Name of the node pool"
}

variable "node_pool_shape" {
  type        = string
  description = "Shape for node pool"
}

variable "node_pool_node_ocpus" {
  type        = number
  description = "OCPUs per node"
}

variable "node_pool_node_memory_in_gbs" {
  type        = number
  description = "Memory per node in GB"
}

variable "node_pool_size" {
  type        = number
  description = "Initial size of the node pool"
}

# ADB
variable "adb_name" {
  type = string
}

variable "adb_display_name" {
  type = string
}

variable "adb_admin_password" {
  type = string
}

variable "adb_cpu_core_count" {
  type = number
}

variable "adb_data_storage_size_in_tbs" {
  type = number
}

variable "adb_is_free_tier" {
  type    = bool
  default = false
}

variable "adb_license_model" {
  type    = string
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "adb_whitelisted_ips" {
  type    = list(string)
  default = []
}

variable "adb_customer_contact_email" {
  type    = string
  default = ""
}

variable "adb_defined_tags" {
  type    = map(string)
  default = {}
}

variable "adb_db_version" {
  type    = string
  default = "23ai"
}

# Vault
variable "vault_name" {
  type        = string
  description = "The name of the vault"
}

variable "vault_key_name" {
  type        = string
  description = "The name of the key in the vault"
}

variable "oke_dynamic_group_name" {
  type        = string
  description = "The name of the dynamic group for OKE nodes"
}

