resource "onprem_servers" "server" {
  name                    = var.name
  inventory_hostname      = var.name
  description             = var.description
  compartment             = var.compartment
  size                    = var.size
  serverrole              = var.serverrole
  inventory_group_name    = var.serverrole
  image                   = var.image
  sversion                = var.sversion
  sstatus                 = var.sstatus
  centercode              = var.centercode
  change                  = var.change
  view                    = var.view
  responsible             = var.managementR
  accountable             = var.managementA
  inform                  = var.managementI
  developer               = var.developer
}

resource "ansible_host" "instance" {
  inventory_hostname = var.name
  groups             = [var.serverrole]

  vars = {
    ansible_user       = "admin"
    hostname           = var.name
  }
}