variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}

#Use this data source to access the configuration of the AzureRM provider.

data "azurerm_client_config" "current" {
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "stterraform2022"
    container_name       = "stcontainerterraform"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = var.cluster_name
#   kubernetes_version  = var.kubernetes_version
#   location            = var.location
#   resource_group_name = azurerm_resource_group.aks-rg.name
#   dns_prefix          = var.cluster_name

#   default_node_pool {
#     name                = "system"
#     node_count          = var.system_node_count
#     vm_size             = "Standard_DS2_v2"
#     type                = "VirtualMachineScaleSets"
#     availability_zones  = [1, 2, 3]
#     enable_auto_scaling = false
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   network_profile {
#     load_balancer_sku = "Standard"
#     network_plugin    = "kubenet" 
#   }
# }


# output "aks_id" {
#   value = azurerm_kubernetes_cluster.aks.id
# }



# resource "local_file" "kubeconfig" {
#   depends_on   = [azurerm_kubernetes_cluster.aks]
#   filename     = "kubeconfig"
#   content      = azurerm_kubernetes_cluster.aks.kube_config_raw
# }

# output "aks_fqdn" {
#   value = azurerm_kubernetes_cluster.aks.fqdn
# }

# output "aks_node_rg" {
#   value = azurerm_kubernetes_cluster.aks.node_resource_group
# }

# output "acr_id" {
#   value = azurerm_container_registry.acr.id
# }

# output "acr_login_server" {
#   value = azurerm_container_registry.acr.login_server
# }