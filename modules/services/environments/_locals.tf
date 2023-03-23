locals {
    # Local is used to collect the ID of the environment for all child modules
    ids = [
        one(module.environment_onprem[*].id),
        #module.environment_azure.rg.id,
    ]       
}