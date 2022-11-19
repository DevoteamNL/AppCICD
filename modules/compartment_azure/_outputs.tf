output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "name" {
  value = {
    for subnet in azurerm_subnet.subnet :
    subnet.name => subnet.name
  }
}

# output "id" {
#   value = {
#     for subnet in azurerm_subnet.subnet :
#     subnet.name => subnet.id
#   }
# }