
resource "oci_database_autonomous_database" "adb_23ai" {
  # Required arguments
  compartment_id = var.compartment_id
  db_name        = var.db_name
  db_workload    = "OLTP"  # Autonomous JSON Database, which supports AI
  display_name   = var.display_name

  # Optional arguments
  admin_password                   = var.admin_password
  are_primary_whitelisted_ips_used = var.are_primary_whitelisted_ips_used
  cpu_core_count                   = var.cpu_core_count
  data_storage_size_in_tbs         = var.data_storage_size_in_tbs
 # db_version                       = "23ai"
  is_free_tier                     = var.is_free_tier
  license_model                    = var.license_model
  is_auto_scaling_enabled          = var.is_auto_scaling_enabled
  is_dedicated                     = false
  is_mtls_connection_required      = true
}
