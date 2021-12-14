
resource "azurerm_resource_group" "resource_group" {
  name     = "resource_group"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "subnet_1"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.1.1.0/24"
}

resource "azurerm_subnet" "subnet_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.1.2.0/24"
}

resource "azurerm_public_ip" "public_ip_1" {
  name                = "virtual_network_gateway_public_ip_1"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "public_ip_2" {
  name                = "virtual_network_gateway_public_ip_2"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "virtual_network_gateway"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = azurerm_public_ip.public_ip_1.name
    public_ip_address_id          = azurerm_public_ip.public_ip_1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_gateway.id
  }

  ip_configuration {
    name                          = azurerm_public_ip.public_ip_2.name
    public_ip_address_id          = azurerm_public_ip.public_ip_2.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_gateway.id
  }
}

