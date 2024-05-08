resource "azurerm_resource_group" "exampleazureapp" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "exampleazureappserviceplan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.exampleazureapp.location
  resource_group_name = azurerm_resource_group.exampleazureapp.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "exampleappserviceplanshow" {
  name                = "example-app-service"
  location            = azurerm_resource_group.exampleazureapp.location
  resource_group_name = azurerm_resource_group.exampleazureapp.name
  app_service_plan_id = azurerm_app_service_plan.exampleazureappserviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
