module "tenant_azure" {
    source               = "../tenant_azure"
    count                = var.prov == "Microsoft" ? 1 : 0
    tenant               = var.name
    location             = var.region
}

module "tenant_onprem" {
    source               = "../tenant_onprem"
    count                = var.prov == "mydc" ? 1 : 0
    name                 = var.name
    party                = var.name
}
