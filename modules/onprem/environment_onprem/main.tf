resource "onprem_environments" "environment" {
  name                    = var.name
  description             = var.description
  etype                   = var.etype
  cloudprovider           = var.cloudprovider
  region                  = var.region
  availabilityzone        = var.az
  application             = var.application
  eversion                = var.eversion
  estatus                 = var.estatus
  centercode              = var.centercode
  change                  = var.change
  view                    = var.view
  responsible             = var.managementR
  accountable             = var.managementA
  inform                  = var.managementI
  developer               = var.developer
}
