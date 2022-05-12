terraform {
  required_providers {
    prov = {
      source  = "prov.tooling.test/tooling/prov"
      version = ">= 0.0.1"
    }
  }
}

provider "prov" {}

# data "prov_images_instance" "frontend" {
#   # most_recent = true
#   # filter {
#   #   name = "os"
#   #   values = [var.Server.os]
#   # }
#   id = "resourceID"
# }

resource "prov_tenants" "MyTenant" {
  name       = var.Tenant
  party      = var.Contract.name
  lifecycle {
    prevent_destroy = true
  }
}

resource "prov_azs" "MyAZ" {
  name        = var.AZ.name
  region      = var.AZ.region
  az          = var.AZ.az
  party       = var.Contract.name
  lifecycle {
    prevent_destroy = true
  }
}

resource "prov_applications" "MyApp" {
  name        = var.Application.name
  party       = var.Contract.name
  status      = var.Application.status
}

resource "prov_environments" "MyEnv" {
  name        = var.Application.name
  party       = var.Contract.name
  pod         = var.Environment.pod
  nos         = var.Environment.nos
  status      = var.Application.status
}

resource "prov_servers" "MyComputer" {
  name        = var.Server.name
  count       = var.Server.count
  env         = var.Server.env
  size        = var.Server.size
  #image       = data.prov_images_instance.frontend.id
  status      = var.Server.status
}