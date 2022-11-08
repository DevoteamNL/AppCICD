module "application_azure" {
    source               = "../application_azure"
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "application_onprem" {
    source               = "../application_onprem"
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}
