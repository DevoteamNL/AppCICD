output "myTenant_id" {
    description = "ID of the generated tenant"
    value       = prov_tenants.MyTenant.id
}

output "myAZ_id" {
    description = "ID of the generated AZ"
    value       = prov_azs.MyAZ.id
}

output "myApp_id" {
    description = "ID of the generated Application"
    value       = prov_applications.MyApp.id
}

output "myEnv_id" {
    description = "ID of the generated Application environment"
    value       = prov_environments.MyEnv.id
}

output "myEnv_subnet" {
    description = "Subnet for the generated Application environment"
    value       = prov_environments.MyEnv.subnet
}

output "myEnv_mask" {
    description = "Subnet Mask of the generated Application environment"
    value       = prov_environments.MyEnv.mask
}

output hostnames {
  value = [for x in module.server : x.hostname]
}