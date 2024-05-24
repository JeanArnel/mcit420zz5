

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  count               = length(var.subnets)
  name                = element(var.subnets, count.index)["name"]
  address_prefixes    = element(var.subnets, count.index)["address_prefixes"]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  count               = length(var.subnets)
  name                = element(var.subnets, count.index)["nsg_name"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                  = length(var.subnets)
  subnet_id              = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The location/region where the virtual network is created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnets" {
  description = "A list of subnet definitions"
  type = list(object({
    name            = string
    address_prefixes = list(string)
    nsg_name        = string
  }))
}
output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = [for subnet in azurerm_subnet.subnet : subnet.id]
}

output "nsg_ids" {
  description = "The IDs of the Network Security Groups"
  value       = [for nsg in azurerm_network_security_group.nsg : nsg.id]
}


module "vnet" {
  source              = "./path/to/vnet_module"
  vnet_name           = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "my-resource-group"
  subnets = [
    {
      name            = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
      nsg_name        = "nsg1"
    },
    {
      name            = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
      nsg_name        = "nsg2"
    }
  ]
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "nsg_ids" {
  value = module.vnet.nsg_ids
}
