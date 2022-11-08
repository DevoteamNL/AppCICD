module "tenants" {
  source   = "./modules/tenants"
  name     = var.tenant
  party    = var.tenant
  prov     = var.environment.cloudprovider
  region   = var.environment.region
}

