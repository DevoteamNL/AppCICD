variable "name" {
  type    = string
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "address_space" {
  type    = list(any)
}