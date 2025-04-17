
variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where the ADB instance will be created"
}

variable "db_name" {
  type        = string
  description = "The database name. It must begin with an alphabetic character and can contain a maximum of 14 alphanumeric characters"
}

variable "display_name" {
  type        = string
  description = "The user-friendly name for the Autonomous Database"
}

variable "admin_password" {
  type        = string
  description = "The password must be between 12 and 30 characters long, and must contain at least 1 uppercase, 1 lowercase, and 1 numeric character"
}

variable "are_primary_whitelisted_ips_used" {
  type        = bool
  description = "Indicates whether to use the primary whitelisted IPs"
  default     = true
}

variable "cpu_core_count" {
  type        = number
  description = "The number of OCPU cores to be made available to the database"
}

variable "data_storage_size_in_tbs" {
  type        = number
  description = "The size, in terabytes, of the data volume that will be created and attached to the database"
}

variable "is_free_tier" {
  type        = bool
  description = "Indicates if this is an Always Free resource"
  default     = false
}

variable "license_model" {
  type        = string
  description = "The Oracle license model that applies to the Oracle Autonomous Database"
  default     = "BRING_YOUR_OWN_LICENSE"
}

variable "is_auto_scaling_enabled" {
  type        = bool
  description = "Indicates whether auto scaling is enabled for the Autonomous Database OCPU core count"
  default     = true
}

variable "database_management_status" {
  type        = string
  description = "The status of Database Management for this Autonomous Database"
  default     = "ENABLED"
}

variable "whitelisted_ips" {
  type        = list(string)
  description = "The client IP addresses that are allowed to access the database"
  default     = []
}

variable "customer_contact_email" {
  type        = string
  description = "The email address used by Oracle to contact the customer"
  default     = ""
}

variable "defined_tags" {
  type        = map(string)
  description = "Defined tags for this resource"
  default     = {}
}

# modules/adb_23ai/outputs.tf

output "adb_id" {
  value       = oci_database_autonomous_database.adb_23ai.id
  description = "The OCID of the Autonomous Database"
}

