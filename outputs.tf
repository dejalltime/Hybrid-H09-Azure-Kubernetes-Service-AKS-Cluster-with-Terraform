output "kube_config" {
  description = "Raw kubeconfig for AKS"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}