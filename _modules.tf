module "tenants" {
  source   = "./modules/tenants"
  prov     = var.environment.cloudprovider
  name     = var.tenant
  party    = var.tenant
  region   = var.environment.region
}

module "environments" {
  source   = "./modules/environments"
  prov     = var.environment.cloudprovider
  name     = var.tenant
  party    = var.tenant
  region   = var.environment.region
  size     = 1
  status   = "Operational"
  address_space = ["10.1.1.0/24"]
}

module "compartments" {
  source               = "./modules/compartments"
  prov                 = var.environment.cloudprovider
  name                 = var.tenant
  region               = var.environment.region
  for_each             = var.compartments
  compartment_name     = each.value.name
  prefix               = each.value.address_prefixes
  vn_name              = module.environments.MyEnv_name
  depends_on = [
    module.environments 
  ]
}