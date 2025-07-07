# Hybrid-H09-Azure-Kubernetes-Service-AKS-Cluster-with-Terraform

## Prerequisites

- Azure CLI logged in (`az login`)
- Terraform v1.1+
- kubectl installed

---

## Deploy AKS with Terraform

```bash
cd path/to/Hybrid-H09-Azure-Kubernetes-Service-AKS-Cluster-with-Terraform
terraform init
terraform apply -auto-approve
```

---

### Notes

- Using `data.azurerm_kubernetes_service_versions` ensures you always pick the newest supported Kubernetes version in your region.
- The cluster scales automatically between 1 and 3 nodes.
- `SystemAssigned` identity allows you to attach Azure-managed permissions later if needed.
- Always store your kubeconfig securely; Terraform marks it as sensitive.
