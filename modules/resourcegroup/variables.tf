variable "resource_group_name" {
  description = "Name of the resource group for the AVD lab"
  type        = string
  default     = "rg-avd-lab-eastus"

  validation {
    condition     = length(var.resource_group_name) > 0 && length(var.resource_group_name) <= 90
    error_message = "Resource group name must be 1-90 characters."
  }
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Common tags applied to all resources in the lab"
  type        = map(string)
  default = {
    Environment = "Lab"
    Project     = "AVD-Lab"
    ManagedBy   = "Terraform"
    Owner       = "Shabeer"
    CostCenter  = "Learning"
  }
}