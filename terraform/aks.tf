# Defines an Azure Kubernetes Service (AKS) cluster resource.
resource "azurerm_kubernetes_cluster" "aks" {

  name                = "aks-${local.tag_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks${local.tag_name}"

  # Configures the default node pool for the AKS cluster.
  default_node_pool {
    name       = "default"
    node_count = 1
    # Specifies the virtual machine size for the nodes in the default node pool.
    vm_size = "standard_d2s_v3"
  }

  # Configures the identity for the AKS cluster.
  identity {
    # Sets the identity type to "SystemAssigned", meaning Azure manages the cluster's identity.
    type = "SystemAssigned"
  }

  # Assigns tags to the AKS cluster for organization and filtering.
  tags = {
    # Tags the cluster with an environment name based on a local variable.
    environment = "${local.tag_name}"
  }

}


resource "azurerm_role_assignment" "ra-perm" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}


