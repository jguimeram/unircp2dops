
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.62.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.8.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = local.tag_name
  }

}


locals {
  tag_name = "casopractico2"
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}


