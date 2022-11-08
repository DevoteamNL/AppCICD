module "tenants" {
  source   = "./modules/tenants"
  name     = var.tenant
  party    = var.tenant
  prov     = var.environment.cloudprovider
  region   = var.environment.region
}

module "environments" {
  source   = "./modules/environments"
  name     = var.tenant
  party    = var.tenant
  prov     = var.environment.cloudprovider
  region   = var.environment.region
  size     = 1
  status   = "Operational"
  address_space = ["10.1.1.0/24"]
}