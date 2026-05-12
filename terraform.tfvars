resource_group_name = "AVD-Lab"
location            = "Southeast Asia"

tags = {
  Environment = "Lab"
  Project     = "AVD_Lab"
  Owner       = "Shabeer"
}

vnet_name          = "Vnet01"
vnet_address_space = ["10.0.0.0/16"]

subnets = {
  dc  = { address_prefixes = ["10.0.1.0/24"] }
  avd = { address_prefixes = ["10.0.2.0/24"] }
}

nsg_name        = "nsg-avd-lab"
admin_source_ip = "49.206.133.67"
