locals {
    # Local is used to collect the ID of the tenant for all child modules
    ids = [
        one(module.tenant_onprem[*].id),
        #module.tenant_azure.subscription.id,
    ]       
}