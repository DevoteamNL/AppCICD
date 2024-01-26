output "cust_router_id" {
    description             = "Value generated by CML to uniquely identify a lab"
    value                   = cml2_node.cust_tenant.id
}

output "cust_router_name" {
    description             = "Value generated by CML to uniquely identify the name of the customer router"
    value                   = "cust_${var.name}"
}
