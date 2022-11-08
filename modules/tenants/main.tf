module "tenant_azure" {
    source               = "../tenant_azure"
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "tenant_onprem" {
    source               = "../tenant_onprem"
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}
