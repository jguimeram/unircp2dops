[vm]
azure_vm ansible_host=${public_ip_address} ansible_user=${admin_username} ansible_ssh_private_key_file=~/.ssh/vm1

[aks]
localhost ansible_host=127.0.0.1 ansible_connection=local

[local]
localhost ansible_host=127.0.0.1 ansible_connection=local