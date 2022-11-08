resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.name  
  location            = var.location
  address_space       = var.address_space
}