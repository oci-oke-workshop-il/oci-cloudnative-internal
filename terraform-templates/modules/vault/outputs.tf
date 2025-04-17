
output "vault_id" {
  value       = oci_kms_vault.vault.id
  description = "The OCID of the vault"
}

output "key_id" {
  value       = oci_kms_key.key.id
  description = "The OCID of the key"
}

output "policy_id" {
  value       = oci_identity_policy.oke_vault_policy.id
  description = "The OCID of the policy"
}