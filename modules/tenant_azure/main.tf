resource "azurerm_resource_group" "MyTenant" {
  name     = var.tenant
  location = var.location
}

# id exported