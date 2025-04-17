output "connection_strings" {
  value       = oci_database_autonomous_database.adb_23ai.connection_strings
  description = "The connection strings for the Autonomous Database"
}

output "connection_urls" {
  value       = oci_database_autonomous_database.adb_23ai.connection_urls
  description = "The connection URLs for the Autonomous Database"
}