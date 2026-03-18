output "resource_group_name" {
  value = "rg-casopractico2"
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.vm1.admin_username
}

