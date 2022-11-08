module "compartment_azure" {
    source               = "../compartment_azure"
    count                = var.environment.cloudprovider == "Microsoft" ? 1 : 0
}

module "compartment_onprem" {
    source               = "../compartment_onprem"
    count                = var.environment.cloudprovider == "mydc" ? 1 : 0
}
