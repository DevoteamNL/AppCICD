locals {
    # Local is used to collect the ID of the compartment for all child modules
    ids = [
        one(module.compartment_onprem[*].id),
        #module.compartment_azure.rg.id,
    ]       
}