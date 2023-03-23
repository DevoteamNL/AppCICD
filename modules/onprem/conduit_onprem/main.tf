resource "onprem_conduits" "conduit" {
  name                    = var.name
  description             = var.description
  ftype                   = var.ftype
  fversion                = var.fversion
  fstatus                 = var.fstatus
  centercode              = var.centercode
  change                  = var.change
  view                    = var.view
  responsible             = var.managementR
  accountable             = var.managementA
  inform                  = var.managementI
  developer               = var.developer

  fsource {
    cloudprovider         = var.fsource.cloudprovider
    region                = var.fsource.region
    availability_zone     = var.fsource.availability_zone
    application           = var.fsource.application      
    environment           = var.fsource.environment      
    compartment           = var.fsource.compartment      
  }

  fdestination {
    cloudprovider         = var.fsource.cloudprovider
    region                = var.fsource.region
    availability_zone     = var.fsource.availability_zone
    application           = var.fsource.application      
    environment           = var.fsource.environment      
    compartment           = var.fsource.compartment      
  }
}
