resource "onprem_compartments" "compartment" {
  name                    = var.name
  description             = var.description
  ctype                   = var.ctype
  cversion                = var.cversion
  cstatus                 = var.cstatus
  environment             = var.environment
  numofservers            = var.numofservers
  addressing              = var.addressing
  centercode              = var.centercode
  change                  = var.change
  view                    = var.view
  responsible             = var.managementR
  accountable             = var.managementA
  inform                  = var.managementI
  developer               = var.developer
}
