module "environment_azure" {
    source               = "../environment_azure"
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "environment_onprem" {
    source               = "../environment_onprem"
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}