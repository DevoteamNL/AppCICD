resource "onprem_tenants" "tenant" {
  name                    = var.name
  description             = var.description
  party                   = var.name
  status                  = var.status
  centercode              = var.centercode
  change                  = var.change
  view                    = var.view
  responsible             = var.managementR
  accountable             = var.managementA
  inform                  = var.managementI
  developer               = var.developer
}
