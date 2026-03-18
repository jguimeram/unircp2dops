# Role: Azure Kubernetes Service (AKS) Application Deployment

This role manages the deployment of a multi-tier application onto an Azure Kubernetes Service (AKS) cluster.

## Requirements

- **Kubectl**: Must be configured and authorized to communicate with the AKS cluster.
- **Ansible Collection**: `kubernetes.core` must be installed.
- **PyYAML & Kubernetes**: Python libraries required by the `k8s` Ansible module on the control node.

## Role Variables

Variables should be provided via a `secrets.yml` file or passed to the playbook.

| Variable | Description |
| :--- | :--- |
| `namespace_name` | The Kubernetes namespace for the application. |
| `backend_image` | The URI of the Redis image (e.g., `{{ acr_name }}.azurecr.io/redis:casopractico2`). |
| `frontend_image` | The URI of the Frontend image (e.g., `{{ acr_name }}.azurecr.io/azure-vote-front:casopractico2`). |

## Tasks Summary

1.  **Create Namespace**: Defines a dedicated Kubernetes namespace for the deployment.
2.  **Storage Provisioning**: Creates a 1Gi `PersistentVolumeClaim` (PVC) for the Redis backend.
3.  **Backend Deployment (Redis)**: Deploys the Redis instance with environment variables for data persistence.
4.  **Backend Service**: Exposes Redis via a `ClusterIP` service for internal communication.
5.  **Frontend Deployment**: Deploys the application frontend, configured to connect to the Redis service.
6.  **Frontend Service**: Exposes the frontend globally via a `LoadBalancer` service (Azure Public IP).

## Example Usage

```yaml
- name: Deploy application to AKS
  hosts: aks
  roles:
    - role: aks
      vars:
        namespace_name: development
        backend_image: myregistry.azurecr.io/redis:casopractico2
        frontend_image: myregistry.azurecr.io/azure-vote-front:casopractico2
```
