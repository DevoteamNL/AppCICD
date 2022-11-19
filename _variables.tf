variable "tenant" {
  description = "Tenant"
  type        = string
}

variable "application" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Environment type: Dev, Test, Acc or Prod"
  type = object({
    name = string
    cloudprovider = string
    region = string
    availability_zone = string
  })
}

variable "compartments" {
  description = "Map containing compartments"
  type = map(object({
    name             = string
    size             = number
    address_prefixes = list(string)
  }))
}

variable "servers" {
  description = "Map containing servers: size following paradigm S/M/L/XL, OS: windows, Linux"
  type = map(object({
    number = string
    name = string
    size = string
    compartment = string
    OS = string
    role = string
  }))
}

variable "conduits" {
  description = "Unidirectional traffic flows."
}

variable "databases" {
  description = "Unidirectional traffic flows."
}
