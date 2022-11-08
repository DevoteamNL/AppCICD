module "tenants" {
  source   = "./modules/tenants"
}

module "applications" {
  source              = "./modules/applications"
}

module "environments" {
  source              = "./modules/environments"
  cloudprovider       = var.environment.cloudprovider
  region              = var.environment.region
}
