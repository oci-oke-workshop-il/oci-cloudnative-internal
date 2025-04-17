# Only user-supplied inputs

compartment_id = "ocid1.compartment.oc1"
oci_cli_profile = "DEFAULT"
region = "il-jerusalem-1"


# VCN variables
vcn_display_name = "oke-vcn-quick-oke-workshop"
vcn_dns_label    = "okeworkshop"
vcn_cidr         = "10.0.0.0/16"

# Subnet variables
lb_subnet_cidr           = "10.0.20.0/24"
node_subnet_cidr         = "10.0.10.0/24"
api_endpoint_subnet_cidr = "10.0.0.0/28"

# OKE variables
cluster_name                = "oke-workshop"
kubernetes_version          = "v1.30.1"
node_pool_name              = "pool1"
node_pool_shape             = "VM.Standard.E4.Flex"
node_pool_node_ocpus        = 1
node_pool_node_memory_in_gbs = 12
node_pool_size              = 3


freeform_tags = {
  "OKEclusterName" = "oke-workshop"
}

# ADB variables
adb_name                   = "myadb23ai"
adb_display_name           = "My ADB AI"
adb_admin_password         = "ComplexPassword123!"
adb_cpu_core_count         = 1
adb_data_storage_size_in_tbs = 1
adb_is_free_tier           = false
adb_license_model          = "BRING_YOUR_OWN_LICENSE"
adb_whitelisted_ips        = ["203.0.113.0/24", "198.51.100.0/24"]
adb_customer_contact_email = "admin@example.com"

# Vault variables
vault_name            = "MyOKEVault"
vault_key_name        = "MyVaultKey"
oke_dynamic_group_name = "OKENodesGroup1j"
