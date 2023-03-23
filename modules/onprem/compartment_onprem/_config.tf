# Specify providers
terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    onprem = {
      source  = "restportal.services.provider.test/datacenter/onprem"
      version = ">= 0.0.1"
    }
  }
}
