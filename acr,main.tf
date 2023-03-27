provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id =var.tenant_id


}
resource "azurerm_resource_group" "testrglabel" {
    name = "concast-prod"
    location = var.location
    tags = {
      "name" = "practice-rsg"

    }
}

resource "azurerm_container_registry" "acr" {
  name                = "concastprod"
  resource_group_name = azurerm_resource_group.testrglabel.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}
