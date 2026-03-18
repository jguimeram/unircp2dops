resource "local_file" "ansible_secrets" {
  content = yamlencode({
    acr_login_server    = azurerm_container_registry.acr.login_server
    acr_user            = azurerm_container_registry.acr.admin_username
    acr_name            = azurerm_container_registry.acr.admin_username
    acr_password        = azurerm_container_registry.acr.admin_password
    aks_name            = azurerm_kubernetes_cluster.aks.name
    rg_name             = azurerm_resource_group.rg.name
    node_resource_group = azurerm_kubernetes_cluster.aks.node_resource_group
  })
  filename = "${path.module}/../ansible/vars/secrets.yml"
}


