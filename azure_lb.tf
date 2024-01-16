locals{
  loadbalancerconfig=[for f in fileset("${path.module}/lbfolder", "[^_]*.yaml") : yamldecode(file("${path.module}/lbfolder/${f}"))]
  loadbalancerlist = flatten([
    for app in local.loadbalancerconfig : [
      for loadbalancer in try(app.loadbalancerconfiguration, []) :{
        name=loadbalancer.publicipname
        allocation_method=loadbalancer.allocation_method
        frontend_ip_configuration=loadbalancer.frontend_ip_configuration
      }
    ]
])
}
resource "azurerm_resource_group" "loadbalancerrg" {
  name     = "LoadBalancerRG"
  location = "West Europe"
}

resource "azurerm_public_ip" "azurepublicipexample" {
  for_each            = {for publicip in local.loadbalancerlist: "${publicip.name}"=>publicip }
  name                = each.value.name
  location            = azurerm_resource_group.loadbalancerrg.location
  resource_group_name = azurerm_resource_group.loadbalancerrg.name
  allocation_method   = each.value.allocation_method
}

resource "azurerm_lb" "azureloadbalancerexample" {
  for_each            = azurerm_public_ip.azurepublicipexample
  name                = each.value.name
  location            = azurerm_resource_group.loadbalancerrg.location
  resource_group_name = azurerm_resource_group.loadbalancerrg.name
  frontend_ip_configuration=tolist{ each.value.frontend_ip_configuration
}
}