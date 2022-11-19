module "compartment_azure" {
    source               = "../compartment_azure"
    name                 = var.compartment_name
    location             = var.region
    resource_group_name  = var.name
    virtual_network_name = var.vn_name
    address_prefixes     = var.prefix

}

module "compartment_onprem" {
    source               = "../compartment_onprem"
}
