module "conduit_azure" {
    source               = ./modules/conduit_azure
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "conduit_onprem" {
    source               = ./modules/conduit_onprem
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}
