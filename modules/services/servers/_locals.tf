locals {
    # Local is used to collect the ID of the server for all child modules
    ids = [
        one(module.server_onprem[*].id),
        #module.server_azure.rg.id,
    ]       
}