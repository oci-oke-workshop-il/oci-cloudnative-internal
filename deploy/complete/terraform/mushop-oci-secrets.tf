resource "null_resource" "install_csi_driver" {
  provisioner "local-exec" {
    command = <<EOT
    # Install Secrets Store CSI Driver and OCI provider
    helm repo add oci-provider https://oracle.github.io/oci-secrets-store-csi-driver-provider/charts
    helm repo update
    helm install oci-provider oci-provider/oci-secrets-store-csi-driver-provider --namespace kube-system
    EOT
  }
  depends_on = [oci_containerengine_node_pool.oke_node_pool]
}
# Dynamically update and apply the SecretProviderClass YAML using Terraform
# Replace placeholders in the YAML file and save it as a new file
resource "local_file" "secret_provider_class" {
  content  = templatefile("../kubernetes/vault/secret-provider-class.yaml", {
    vault_ocid = oci_kms_vault.mushop_vault[0].id
  })
  filename = "../kubernetes/vault/secret-provider-class.yaml"
}

# Use a null_resource with a local-exec provisioner to apply the updated YAML using kubectl
resource "null_resource" "apply_secret_provider_class" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.secret_provider_class.filename}"
  }

  depends_on = [
    oci_containerengine_node_pool.oke_node_pool,
    oci_kms_vault.mushop_vault, 
    oci_vault_secret.oadb_admin_secret, 
    oci_vault_secret.oadb_wallet_secret, 
    oci_vault_secret.oadb_connection_secret,
    local_file.secret_provider_class
  ]
}
