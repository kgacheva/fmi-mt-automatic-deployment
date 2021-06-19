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

module "azure-builder-worker-subnet" {
    source                     = "../common/subnet-deploy"
    az_subnet_name             = var.az_subnet_name
    az_rg_name                 = module.azure-builder-worker-rg.out_az_rg.name
    az_service_principal       = var.az_service_principal
    az_subnet_vnet_name        = module.azure-builder-worker-vnet.out_az_vnet.name
    az_subnet_address_prefixes = var.az_subnet_address_prefixes
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

module "azure-builder-worker-vnic" {
    source                      = "../common/vnic-deploy"
    az_vnic_name                = var.az_vnic_name
    az_vnic_location            = module.azure-builder-worker-rg.out_az_rg.location
    az_rg_name                  = module.azure-builder-worker-rg.out_az_rg.name
    az_service_principal        = var.az_service_principal
    az_vnic_ip_config_name      = var.az_vnic_ip_config_name
    az_vnic_pub_ip_id           = module.azure-builder-worker-pub-ip.out_az_public_ip.id
    az_vnic_subnet_id           = module.azure-builder-worker-subnet.out_az_subnet.id
    az_vnic_nsg_assoc_nsg_id    = module.azure-builder-worker-net-sec-group.out_az_net_sec_group.id
}
