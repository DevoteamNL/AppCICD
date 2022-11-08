resource "azurerm_resource_group" "tenant" {
  name     = var.tenant
  location = var.environment.region
}
