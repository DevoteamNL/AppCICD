# Specify providers
terraform {
  required_providers {
    prov = {
      source  = "prov.tooling.test/tooling/prov"
      version = ">= 0.0.1"
    }
  }
}
