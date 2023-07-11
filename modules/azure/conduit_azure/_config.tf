# Specify providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.49"
    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
}
