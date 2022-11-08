variable "Contract" {
  description = "The contract holder for the application."
  type        = map
  default     = {
      name       = "Contractor"
      costcenter = "123456789"
      status     = "Active"
  }
}

variable "Tenant" {
  description = "The tenant owning applications."
  type        = string
  default     = "Contractor"
}

variable "AZ" {
  description = "The App-AZ hosting the application."
  type        = map
  default     = {
      name       = "AP01"
      region     = "EU-31-1"
      az         = "DC/3"
      party      = "Contractor"
  }
}

variable "Application" {
  description = "The application."
  type        = map
  default     = {
      name       = "MyApp"
      party      = "Contractor"
      status     = "RFS"
  }
}

variable "Environment" {
  description = "The DEV environment."
  type        = map
  default     = {
      name       = "DEV"
      app        = "MyApp"
      pod        = "AP01"
      nos        = 24
      status     = "RFS"
  }
}

variable "Server" {
    type         = map
    default      = {
        name        = "fe"
        count       = 10
        env         = "Dev"
        size        = "XL"
        os          = "Windows_core"
        status      = "RFS"
    }
}

variable "Azure_serversizes" {
  type        = map(string)
  default = {
    "S"     = "Standard_B1s"
    "M"     = "Standard_B1s"
    "L"     = "Standard_B1s"
    "XL"    = "Standard_B1s"
  }
}

