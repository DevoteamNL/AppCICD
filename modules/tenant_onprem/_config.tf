# Specify providers
terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    prov = {
      source  = "prov.tooling.test/tooling/prov"
      version = ">= 0.0.1"
    }
  }
}
