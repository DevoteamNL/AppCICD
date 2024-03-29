output "id" {
    description = "Value generated by the back-end to uniquely identify a compartment"
    value = onprem_compartments.compartment.id
}

output "subnet" {
    description = "Value generated by the back-end providing the subnet of the compartment"
    value = onprem_compartments.compartment.subnet
}

output "subnetmask" {
    description = "Value generated by the back-end providing the subnetmask for the compartment"
    value = onprem_compartments.compartment.subnetmask
}
