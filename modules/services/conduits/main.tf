module "conduit_onprem" {
    source               = "../../onprem/conduit_onprem"
    count                = var.prov == "OnPrem" ? 1 : 0
    name                 = var.name
    description          = var.description
    ftype                = var.ftype
    fsource              = var.fsource
    fdestination         = var.fdestination
    fversion             = var.fversion
    fstatus              = var.fstatus
    centercode           = var.centercode
    change               = var.change
    view                 = var.view
    managementR          = var.managementR
    managementA          = var.managementA
    managementI          = var.managementI
    developer            = var.developer
}
