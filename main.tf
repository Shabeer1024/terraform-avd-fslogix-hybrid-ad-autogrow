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
  depends_on = [module.resource_group]
}


resource "random_password" "dc_admin" {
  length           = 20
  special          = true
  override_special = "!@#%^&*()-_=+[]{}<>?,."   # ← removed $, ", `, ', \, /, :, ;, |
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "random_password" "dc_safe_mode" {
  length           = 20
  special          = true
  override_special = "!@#%^&*()-_=+[]{}<>?,."
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

module "domain_controller" {
  source = "./modules/dc"

  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.networking.subnet_ids["dc"]
  virtual_network_id  = module.networking.vnet_id

  vm_name        = var.dc_vm_name
  vm_size        = var.dc_vm_size
  admin_username = var.dc_admin_username
  admin_password = random_password.dc_admin.result

  private_ip_address = var.dc_private_ip
  domain_name        = var.domain_name
  safe_mode_password = random_password.dc_safe_mode.result

  install_script = templatefile("${path.module}/scripts/install-ad.ps1.tftpl", {
    domain_name            = var.domain_name
    netbios_name           = upper(split(".", var.domain_name)[0])
    safe_mode_password_b64 = base64encode(random_password.dc_safe_mode.result)
  })

  auto_shutdown_time     = var.auto_shutdown_time
  auto_shutdown_timezone = var.auto_shutdown_timezone
  tags                   = var.tags

  depends_on = [module.networking]
}