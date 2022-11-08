module "environment_azure" {
    source               = "../environment_azure"
    count                = var.prov == "Microsoft" ? 1 : 0
    name                 = var.name
    location             = var.region
    address_space        = var.address_space
}

module "environment_onprem" {
    source               = "../environment_onprem"
    count                = var.prov == "mydc" ? 1 : 0
    name                 = var.name
    party                = var.name
}
