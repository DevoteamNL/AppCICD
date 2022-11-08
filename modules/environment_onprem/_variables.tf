variable "name" {
  type    = string
}

variable "party" {
  type    = string
}

variable "pod" {
  type    = string
  default = "AP01"
}

variable "size" {
  type    = number
  default = 1
}

variable "status" {
  type    = string
  default = "Operational"
}