---
title: Azure VNET Creation
tags: Azure VNET
---

# Azure VNET
This code is written and used as an example for  creating a simple Azure VNET. 

### main.tf 
The [Azure VNET module](https://registry.terraform.io/modules/Azure/vnet/azurerm/latest) can be used to quickly setup an Azure VNET. With a few variables passed in, a  resource group, subnets, Service Endpoints and tags can be created.  

```hcl tangle:./main.tf

resource "azurerm_resource_group" "resource_group" {
  name     = "resource_group"
  location = var.region
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
  address_prefixes       = ["10.1.1.0/24"]
}

# The VPN Tunnel Subnet
resource "azurerm_subnet" "subnet_gateway" {
  # The name "GatewaySubnet" is mandatory
  # Only one "GatewaySubnet" is allowed per vNet
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = ["10.1.2.0/24"]
}

```

### backend.tf 
The backend file is to specify the location and name of the state file.
Below we are storing state in the local current directory
The statefile will not be created until a `terraform init` is run. 

```hcl tangle:./backend.tf
terraform {
  required_version = "~> 1.0.11"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "PublicSector-ATARC"

    workspaces {
      name = "fse-tf-atarc-azure-vnet"
    }
  }
}
```

### providers.tf
The [provider file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) is what Terraform Core interacts with in order to bring in different providers like AWS, Azure etc. In the following provider we are using the [AWS provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs).  To interact with the provider for Azure, the subscription ID, client ID, client secret and tenant ID. 

```hcl tangle:./providers.tf
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
```

### variables.tf
The following variables can be updated in the file or passed in during the execution of a `terraform plan` or a `terraform apply`


**Example:**

```
terraform init
terraform apply \
-var="subscription_id=${ARM_SUBSCRIPTION_ID}" \ 
-var="client_id=${ARM_CLIENT_ID}" \  
-var="client_secret=${ARM_CLIENT_SECRET}" \ 
-var="tenant_id=${ARM_TENANT_ID}" \ 
-auto-approve
```


```hcl tangle:./variables.tf

variable "name" {
  type        = string
  description = "Name that will flow through the VNET resources"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

```


```hcl tangle:./outputs.tf
output "location" {
  value = azurerm_resource_group.resource_group.location
  description = "Resource Group Location"
}

output "rg_name" {
  value = azurerm_resource_group.resource_group.name
}

output "rg_id" {
  value = azurerm_resource_group.resource_group.id
}

output "cidr" {
  value = azurerm_virtual_network.vnet.address_space[0]
  description = "Address CIDR"
}

output "subnet_gateway"  {
  value = azurerm_subnet.subnet_gateway.address_prefixes[0]
}

output "subnet_1"  {
  value = azurerm_subnet.subnet_1.address_prefixes[0]
}

output "subnet_gateway_id"  {
  value = azurerm_subnet.subnet_gateway.id
}

output "subnet_1_id"  {
  value = azurerm_subnet.subnet_1.id
}


```
