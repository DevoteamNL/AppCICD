variable "tenant" {
    type    = string
}
variable "name" {
    type    = string
}
variable "application" {
    type    = string
}

variable "environment" {
    type    = object ({
        etype               = string, 
        cloudprovider       = string,
        region              = string,
        availability_zone   = string,
        name                = string,
        eversion            = string,
        centercode          = string,
        change              = string,
        view                = string,
        management-r        = string,
        management-a        = string,
        management-i        = string,
        developer           = string
        })              
}

variable "compartments" {
    type = map(object({
            name                = string,
            description         = string,
            ctype               = string,
            cversion            = string,
            cstatus             = string,
            environment         = string,
            centercode          = string,
            change              = string,
            view                = string,
            management-r        = string,
            management-a        = string,
            management-i        = string,
            developer           = string,
            numofservers        = number,
            addressing          = string
            })            
        )
         
}

variable "servers" {
    type    = map(object({
            name                = string, 
            description         = string,
            compartment         = string,
            size                = string,
            serverrole          = string,
            image               = string,
            sversion            = string,
            sstatus             = string,
            centercode          = string,
            change              = string,
            view                = string,
            management-r        = string,
            management-a        = string,
            management-i        = string,
            developer           = string
        })
    )
}

variable "conduits" {
    type    = object ({})
}

variable "databases" {
    type    = object ({})
}
