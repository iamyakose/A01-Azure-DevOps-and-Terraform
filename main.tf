# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tf_example" {
  name     = "tf_example-resources"
  location = "North Europe"
}

resource "azurerm_container_group" "tfcg_example" {
  name                = "weatherapi"
  location            = azurerm_resource_group.tf_example.location
  resource_group_name = azurerm_resource_group.tf_example.name
  ip_address_type     = "Public"
  dns_name_label      = "yakosewa"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "yakose/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }  
  
}
