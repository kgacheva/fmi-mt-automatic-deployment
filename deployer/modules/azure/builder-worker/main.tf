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

module "azure-builder-worker-pub-ip" {
    source                      = "../common/public-ip-deploy"
    az_pub_ip_name              = var.az_pub_ip_name
    az_pub_ip_allocation_method = var.az_pub_ip_allocation_method
    az_pub_ip_location          = module.azure-builder-worker-rg.out_az_rg.location
    az_rg_name                  = module.azure-builder-worker-rg.out_az_rg.name
    az_service_principal        = var.az_service_principal
}

module "azure-builder-worker-net-sec-group" {
    source                      = "../common/net-sec-group-deploy"
    az_nsg_name                 = var.az_nsg_name
    az_nsg_location             = module.azure-builder-worker-rg.out_az_rg.location
    az_rg_name                  = module.azure-builder-worker-rg.out_az_rg.name
    az_service_principal        = var.az_service_principal
    az_nsg_security_rule        = var.az_nsg_security_rule
}
