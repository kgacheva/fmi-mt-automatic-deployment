module "azure-builder-worker-rg" {
    source              = "../common/rg-deploy"
    az_rg_name           = var.az_rg_name
    az_rg_location       = var.az_rg_location
    az_service_principal = var.az_service_principal
}

module "azure-builder-worker-vnet" {
    source                = "../common/vnet-deploy"
    az_vnet_name          = var.az_vnet_name
    az_vnet_location      = module.azure-builder-worker-rg.out_az_rg.location
    az_rg_name            = module.azure-builder-worker-rg.out_az_rg.name
    az_service_principal  = var.az_service_principal
    az_vnet_address_space = var.az_vnet_address_space
}
