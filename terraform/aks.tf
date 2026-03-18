resource "azurerm_kubernetes_cluster" "aks" {

  name                = "aks-${local.tag_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks${local.tag_name}"


  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2s_v3"
  }


  identity {
    type = "SystemAssigned"
  }


  tags = {
    environment = "${local.tag_name}"
  }

}

resource "azurerm_role_assignment" "ra-perm" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}


