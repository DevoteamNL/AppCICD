resource "prov_tenants" "MyTenant" {
  name       = var.tenant
  party      = var.tenant
  lifecycle {
    prevent_destroy = true
  }
}