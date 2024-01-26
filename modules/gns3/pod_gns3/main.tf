resource "gns3_lab" "AppPoDSim" {
  title       = "${var.prov}_${replace(var.region," ","")}_${var.name}"
}

resource "ansible_group" "PoD" {
  inventory_group_name = "${var.prov}_${replace(var.region," ","")}_${var.az}"
  children = ["data","services","sysbeheer","podinfra",var.environment]
  vars = {
    pod_name = "${var.prov}_${replace(var.region," ","")}_${var.name}"
  }
}
