output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "address_space" {
  value = module.vnet.vnet_address_space
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_location" {
  value = module.vnet.vnet_location
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "vnet_subnets" {
  value = module.vnet.vnet_subnets
}
