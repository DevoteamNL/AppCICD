output "id" {
    description = "Value generated by the back-end to uniquely identify a tenant"
    value = cml2_tenants.tenant.id
}
