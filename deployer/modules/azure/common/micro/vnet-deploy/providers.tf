provider "azurerm" {
  features {}

  subscription_id = var.az_service_principal.subscription_id
  client_id       = var.az_service_principal.client_id
  client_secret   = var.az_service_principal.client_secret
  tenant_id       = var.az_service_principal.tenant_id
}
