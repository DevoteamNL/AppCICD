module "tenants" {
    source               = "./modules/services/tenants"
    prov                 = var.environment.cloudprovider
    name                 = var.tenant
    description          = var.tenant
    status               = "Operational"
    centercode           = var.environment.centercode
    change               = var.environment.change
    view                 = var.environment.view
    managementR          = var.environment.management-r
    managementA          = var.environment.management-a
    managementI          = var.environment.management-i
    developer            = var.environment.developer
}

module "applications" {
    source               = "./modules/services/applications"
    prov                 = var.environment.cloudprovider
    name                 = var.tenant
    description          = var.tenant
    apptenant            = module.tenants.id
    status               = "Operational"
    centercode           = var.environment.centercode
    change               = var.environment.change
    view                 = var.environment.view
    managementR          = var.environment.management-r
    managementA          = var.environment.management-a
    managementI          = var.environment.management-i
    developer            = var.environment.developer

    depends_on = [
    module.tenants
  ]
}

module "environments" {
    source               = "./modules/services/environments"
    prov                 = var.environment.cloudprovider
    name                 = var.tenant
    description          = var.tenant
    etype                = var.environment.etype
    cloudprovider        = var.environment.cloudprovider
    region               = var.environment.region
    az                   = var.environment.availability_zone
    application          = module.applications.id
    eversion             = var.environment.eversion
    estatus              = "Operational"
    centercode           = var.environment.centercode
    change               = var.environment.change
    view                 = var.environment.view
    managementR          = var.environment.management-r
    managementA          = var.environment.management-a
    managementI          = var.environment.management-i
    developer            = var.environment.developer

    depends_on = [
    module.applications
    ]
}

module "compartments" {
    source               = "./modules/services/compartments"
    prov                 = var.environment.cloudprovider
    for_each             = var.compartments
    name                 = each.value.name
    description          = each.value.description
    ctype                = each.value.ctype
    cversion             = each.value.cversion
    cstatus              = each.value.cstatus
    environment          = module.environments.id
    centercode           = each.value.centercode
    change               = each.value.change
    view                 = each.value.view
    managementR          = each.value.management-r
    managementA          = each.value.management-a
    managementI          = each.value.management-i
    developer            = each.value.developer
    numofservers         = each.value.numofservers
    addressing           = each.value.addressing

    depends_on = [
    module.environments
    ]
}

module "servers" {
    source               = "./modules/services/servers"
    prov                 = var.environment.cloudprovider
    for_each             = var.servers
    name                 = each.value.name
    description          = each.value.description
    compartment          = each.value.compartment
    size                 = each.value.size
    serverrole           = each.value.serverrole
    image                = each.value.image
    sversion             = each.value.sversion
    sstatus              = each.value.sstatus
    centercode           = each.value.centercode
    change               = each.value.change
    view                 = each.value.view
    managementR          = each.value.management-r
    managementA          = each.value.management-a
    managementI          = each.value.management-i
    developer            = each.value.developer

    depends_on = [
    module.compartments
    ]
}
