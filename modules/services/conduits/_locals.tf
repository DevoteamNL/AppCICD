locals {
    # Local is used to collect the ID of the conduit for all child modules
    ids = [
        one(module.conduit_onprem[*].id),
        #module.conduit_azure.rg.id,
    ]       
}