provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id


  
}
resource "azurerm_app_service_plan" "testappplan" {
    name = "testappplan"
    location = var.location
    resource_group_name = "concast"
    kind = "Linux"
    reserved = true
    sku {
      tier = "Basic"
      size = "B1"

    }

 tags = {
  "name" = "practice-appplan"
}
}
locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "terraformnodejs.azurecr.io"
   DOCKER_REGISTRY_SERVER_USERNAME       = "terraformnodejs"
   DOCKER_REGISTRY_SERVER_PASSWORD       = "0wl69UCqsJVs67Et3I0qCd3vVauD4gFIr+2H2zlGYf+ACRAUT5Dj"
 }  
}
resource "azurerm_app_service" "testwebapp" {
    name = "concast-prod"
    location = var.location
    resource_group_name = "concast"
    app_service_plan_id = azurerm_app_service_plan.testappplan.id
    site_config {
    linux_fx_version = "DOCKER|terraformnodejs.azurecr.io/terraformnodejs"
    # registry_source="ACR"

  }
  
    app_settings = local.env_variables
    
}

output "id" {
  value = azurerm_app_service_plan.testappplan.id
}
