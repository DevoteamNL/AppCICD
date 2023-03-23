# Specify providers
terraform {
  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = ">=3.23.0"
#    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    onprem = {
      source  = "restportal.services.provider.test/datacenter/onprem"
      version = ">= 0.0.1"
    }
  }

  backend "pg" {
    conn_str = "postgres://terraform:terraform@cicdtoolbox-db.internal.provider.test/terraform"

  }
}

# # Configure the Microsoft Azure Provider
# provider "azurerm" {
#   features {}
# }

provider "onprem" {
}

