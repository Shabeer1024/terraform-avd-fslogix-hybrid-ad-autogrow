module "resource_group" {
  source              = "./modules/resourcegroup"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "networking" {
  source = "./modules/vnet"
  resource_group_name = var.resource_group_name # ← creates dependency on Step 1
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnets             = var.subnets
  nsg_name            = var.nsg_name
  admin_source_ip     = var.admin_source_ip
  tags                = var.tags
}