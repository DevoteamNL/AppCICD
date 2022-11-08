variable "name" {
      type    = string
}

variable "prov" {
    type    = string
}

variable "party" {
    type    = string
}

variable "region" {
    type    = string
}

variable "size" {
  description = "Number of Servers"
  type        = number
  default     = 1
}

variable "status" {
  type    = string
  default = "Operational"
}

variable "address_space" {
  type    = list(any)
  default = ["10.1.0.0/24"]
}