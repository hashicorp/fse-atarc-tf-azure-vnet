# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "location" {
  value       = azurerm_resource_group.resource_group.location
  description = "Resource Group Location"
}

output "rg_name" {
  value = azurerm_resource_group.resource_group.name
}

output "rg_id" {
  value = azurerm_resource_group.resource_group.id
}

output "cidr" {
  value       = azurerm_virtual_network.vnet.address_space[0]
  description = "Address CIDR"
}

output "subnet_gateway" {
  value = azurerm_subnet.subnet_gateway.address_prefixes[0]
}

output "subnet_1" {
  value = azurerm_subnet.subnet_1.address_prefixes[0]
}

output "subnet_gateway_id" {
  value = azurerm_subnet.subnet_gateway.id
}

output "subnet_1_id" {
  value = azurerm_subnet.subnet_1.id
}


