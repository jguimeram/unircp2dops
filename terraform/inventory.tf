resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/inventory.tmpl"
  file_permission = "0644"
  content = templatefile("${path.module}/inventory.tpl", {
    public_ip_address = azurerm_public_ip.pip.ip_address
    admin_username    = azurerm_linux_virtual_machine.vm1.admin_username
  })
}
