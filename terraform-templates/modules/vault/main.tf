resource "oci_kms_vault" "vault" {
  compartment_id = var.compartment_id
  display_name   = var.vault_name
  vault_type     = var.vault_type
}

resource "oci_kms_key" "key" {
  compartment_id = var.compartment_id
  display_name   = var.key_name
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  management_endpoint = oci_kms_vault.vault.management_endpoint
}

resource "oci_identity_policy" "oke_vault_policy" {
  compartment_id = var.compartment_id
  description    = "Allow OKE cluster access to secrets in vault"
  name           = var.policy_name

  statements = [
    "Allow dynamic-group ${var.oke_nodes_dynamic_group_name} to read secret-bundles in compartment id ${var.compartment_id}",
    "Allow dynamic-group ${var.oke_nodes_dynamic_group_name} to use keys in compartment id ${var.compartment_id}",
    "Allow dynamic-group ${var.oke_nodes_dynamic_group_name} to manage secret-family in compartment id ${var.compartment_id}"
  ]
}
