module "database_azure" {
    source               = ./modules/database_azure
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "database_onprem" {
    source               = ./modules/database_onprem
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}
