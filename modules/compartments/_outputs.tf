output compartments {
  value = [for c in module.compartment_azure : c.name]
}