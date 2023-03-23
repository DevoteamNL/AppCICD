module "server_onprem" {
    source               = "../../onprem/server_onprem"
    count                = var.prov == "OnPrem" ? 1 : 0
    name                 = var.name
    description          = var.description
    compartment          = var.compartment
    size                 = var.size
    serverrole           = var.serverrole
    image                = var.image
    sversion             = var.sversion
    sstatus              = var.sstatus
    centercode           = var.centercode
    change               = var.change
    view                 = var.view
    managementR          = var.managementR
    managementA          = var.managementA
    managementI          = var.managementI
    developer            = var.developer
}
