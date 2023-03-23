module "compartment_onprem" {
    source               = "../../onprem/compartment_onprem"
    count                = var.prov == "OnPrem" ? 1 : 0
    name                 = var.name
    description          = var.description
    ctype                = var.ctype
    cversion             = var.cversion
    cstatus              = var.cstatus
    environment          = var.environment
    numofservers         = var.numofservers
    addressing           = var.addressing
    centercode           = var.centercode
    change               = var.change
    view                 = var.view
    managementR          = var.managementR
    managementA          = var.managementA
    managementI          = var.managementI
    developer            = var.developer
}
