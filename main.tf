terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
}

provider "azurerm" {
    subscription_id = var.subscription_id
    features {}
}

# Fetch available AKS versions in this region
data "azurerm_kubernetes_service_versions" "available" {
  location = var.location
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"

    default_node_pool {
       name       = "agentpool"
       vm_size    = "Standard_B2s"
       node_count = 1
    }

  identity {
    type = "SystemAssigned"
  }

  # pick the latest version
  kubernetes_version = data.azurerm_kubernetes_service_versions.available.versions[0]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "autoscale" {
  name                  = "autoscale"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_B2s"
  node_count            = 1
  mode                  = "System"

  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 3
}