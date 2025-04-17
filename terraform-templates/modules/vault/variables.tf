variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where the vault will be created"
}

variable "vault_name" {
  type        = string
  description = "The name of the vault"
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create"
  default     = "DEFAULT"
}

variable "key_name" {
  type        = string
  description = "The name of the key"
}

variable "oke_nodes_dynamic_group_name" {
  type        = string
  description = "The name of the dynamic group for OKE nodes"
}

variable "policy_name" {
  type        = string
  description = "The name of the policy"
}

