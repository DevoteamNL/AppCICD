resource "prov_environments" "MyEnv" {
  name        = var.name
  party       = var.party
  pod         = var.pod
  nos         = var.size
  status      = var.status
}