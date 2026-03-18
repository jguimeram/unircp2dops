# Role: Virtual Machine (VM) Configuration and Deployment

This role configures a Virtual Machine running Ubuntu to host a containerized Nginx application using Podman.

## Requirements

- **SSH Access**: The target host must be reachable via SSH.
- **Sudo Privileges**: `become: true` is required for system-level changes (e.g., `apt` installs).
- **Ansible Collections**: `containers.podman` must be installed.

## Role Variables

Variables should be provided via a `secrets.yml` file or passed to the playbook.

| Variable | Description |
| :--- | :--- |
| `acr_name` | The name of the Azure Container Registry. |
| `acr_user` | The username for ACR (typically same as `acr_name`). |
| `acr_password` | The password or access key for ACR. |

## Role Files

- **`files/`**: Contains the source code for the Nginx application (HTML, CSS, JS) and the `Containerfile`.

## Tasks Summary

1.  **System Preparation**: Updates and upgrades the system packages via `apt`.
2.  **Install Podman**: Installs the Podman container engine.
3.  **Login to ACR**: Authenticates Podman with the Azure Container Registry.
4.  **Copy Source Code**: Transfers the Nginx application files to `~/nginx-app/` on the VM.
5.  **Build Custom Image**: Builds the `my-app:casopractico2` image using the local `Containerfile`.
6.  **Push to ACR**: Uploads the custom image to the private Azure Container Registry.
7.  **Run Application**: Deploys the application as a Podman container, mapping host port 80 to container port 80.
8.  **Verify**: Checks and registers the container status.

## Example Usage

```yaml
- name: Deploy application to VM
  hosts: azure_vm
  become: true
  roles:
    - role: vm
      vars:
        acr_name: myregistry
        acr_user: myregistry
        acr_password: mysecretpassword
```
