# Specify providers
terraform {
  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = ">=3.23.0"
#    }
    cml2 = {
      source  = "registry.terraform.io/ciscodevnet/cml2"
    }
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

provider "cml2" {
  address     = var.cml_url
  username    = var.cml_username
  password    = var.cml_password
  skip_verify = true
} 