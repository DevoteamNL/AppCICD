resource "prov_tenants" "MyTenant" {
  name       = var.name
  party      = var.party
  lifecycle {
    prevent_destroy = true
  }
}