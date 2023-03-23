locals {
    # Local is used to collect the ID of the application for all child modules
    ids = [
        one(module.application_onprem[*].id),
        #module.application_azure.rg.id,
    ]       
}