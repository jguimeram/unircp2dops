# devopsunircp2

![Licencia](https://img.shields.io/badge/licencia-MIT-blue.svg)
![Lenguaje](https://img.shields.io/badge/lenguaje-HCL%20%7C%20YAML%20%7C%20Shell-informational.svg)

> **devopsunircp2** es un proyecto integral de DevOps que automatiza el despliegue de una aplicación contenedorizada en Azure Kubernetes Service (AKS). Utiliza Terraform como Infraestructura como Código (IaC) para aprovisionar recursos en Azure, incluyendo clústeres de AKS, Azure Container Registry (ACR) y Máquinas Virtuales. Ansible se encarga de la gestión de la configuración y el despliegue de la aplicación, manejando la configuración de espacios de nombres (namespaces) de Kubernetes, despliegues, servicios (LoadBalancer) y clústeres de Redis.

## ✨ Características

- Aprovisionamiento de infraestructura en Azure mediante Terraform (HCL).
- Pipeline de despliegue automatizado en Kubernetes con Ansible (YAML).
- Integración con Azure Container Registry (ACR) para la gestión de imágenes.
- Despliegue de aplicación multi-capa (Frontend, Backend, Redis) en AKS.
- Generación dinámica de inventario para Ansible a partir de las salidas de Terraform.
- Estructura modular de Ansible basada en roles para una gestión de configuración limpia.

## 🏗️ Arquitectura del Proyecto

El proyecto está organizado en dos componentes principales:

1.  **Terraform (`/terraform`):** Define los recursos de Azure necesarios:
    *   `aks.tf`: Configuración del clúster de Kubernetes.
    *   `acr.tf`: Registro de contenedores para almacenar imágenes.
    *   `vm.tf`: Una máquina virtual auxiliar.
    *   `inventory.tf`: Genera automáticamente el archivo de inventario para Ansible.

2.  **Ansible (`/ansible`):** Gestiona la configuración post-aprovisionamiento:
    *   **Rol `acr`:** Configura y gestiona el registro de contenedores.
    *   **Rol `aks`:** Realiza el despliegue en Kubernetes (Namespace, PVC, Redis, Backend, Frontend y LoadBalancer).
    *   **Rol `vm`:** Configura la máquina virtual con una aplicación de ejemplo.

## 🚀 Instalación y Despliegue

Sigue estos pasos para poner en marcha el proyecto:

```bash
# 1. Clonar el repositorio
git clone <url-del-repositorio>
cd devopsunircp2

# 2. Inicializar y aplicar Terraform
cd terraform
terraform init
terraform apply -auto-approve

# 3. Ejecutar el playbook de Ansible
cd ../ansible
ansible-playbook playbook.yml
```

## 📄 Licencia

Copyright © 2026. Licenciado bajo la licencia [MIT](./LICENSE).
