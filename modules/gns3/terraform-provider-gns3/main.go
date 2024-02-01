package main

import (
    "context"
    "log"

    "terraform-provider-gns3/internal/provider"

    "github.com/hashicorp/terraform-plugin-framework/providerserver"
)

func main() {
    opts := providerserver.ServeOpts{
        Address: "registry.terraform.io/devoteamnl/gns3",
        Debug:   debug,
    }

    err := providerserver.Serve(context.Background(), provider.New(), opts)
    if err != nil {
        log.Fatal(err.Error())
    }
}