# modules/oke/outputs.tf

output "cluster_id" {
  description = "The OCID of the OKE cluster"
  value       = oci_containerengine_cluster.oke_cluster.id
}

output "cluster_kubernetes_version" {
  description = "The version of Kubernetes running on the cluster"
  value       = oci_containerengine_cluster.oke_cluster.kubernetes_version
}

output "cluster_name" {
  description = "The name of the OKE cluster"
  value       = oci_containerengine_cluster.oke_cluster.name
}

output "node_pool_id" {
  description = "The OCID of the node pool"
  value       = oci_containerengine_node_pool.oke_node_pool.id
}

output "node_pool_kubernetes_version" {
  description = "The version of Kubernetes running on the node pool"
  value       = oci_containerengine_node_pool.oke_node_pool.kubernetes_version
}

output "kubeconfig_path" {
  description = "The path to the generated kubeconfig file"
  value       = local_file.kubeconfig.filename
}

output "dynamic_group_name" {
  value       = var.create_dynamic_group ? oci_identity_dynamic_group.oke_nodes_dynamic_group[0].name : ""
  description = "The name of the dynamic group for OKE nodes"
}