# Role: Azure Container Registry (ACR) Management

This role synchronizes required container images from external registries (like Docker Hub) to a private Azure Container Registry (ACR).

## Requirements

- **Podman**: Installed on the controller or the target host where this role is executed.
- **Ansible Collection**: `containers.podman` must be installed.

## Role Variables

Variables should be provided via a `secrets.yml` file or passed to the playbook.

| Variable | Description |
| :--- | :--- |
| `acr_name` | The name of the Azure Container Registry. |
| `acr_user` | The username for ACR (typically same as `acr_name`). |
| `acr_password` | The password or access key for ACR. |

## Tasks Summary

1.  **Login to ACR**: Authenticates Podman with the specified Azure Container Registry.
2.  **Sync Frontend Image**: Pulls `azure-vote-front:v1` from Docker Hub, tags it, and pushes it to the ACR with the tag `casopractico2`.
3.  **Sync Backend Image**: Pulls `redis:6.0.8` from Docker Hub, tags it, and pushes it to the ACR with the tag `casopractico2`.

## Example Usage

```yaml
- name: Synchronize images to ACR
  hosts: localhost
  roles:
    - role: acr
      vars:
        acr_name: myregistry
        acr_user: myregistry
        acr_password: mysecretpassword
```
