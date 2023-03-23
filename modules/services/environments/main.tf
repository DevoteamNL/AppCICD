module "environment_onprem" {
    source               = "../../onprem/environment_onprem"
    count                = var.prov == "OnPrem" ? 1 : 0
    name                 = var.name
    description          = var.description
    etype                = var.etype
    cloudprovider        = var.cloudprovider
    region               = var.region
    az                   = var.az
    application          = var.application
    eversion             = var.eversion
    estatus              = var.estatus
    centercode           = var.centercode
    change               = var.change
    view                 = var.view
    managementR          = var.managementR
    managementA          = var.managementA
    managementI          = var.managementI
    developer            = var.developer
}
