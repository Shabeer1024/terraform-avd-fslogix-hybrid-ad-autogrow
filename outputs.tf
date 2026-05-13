
# =============================================================================
# Step 3 - Domain Controller (added by apply-step3.ps1)
# =============================================================================
output "dc_vm_name" {
  value = module.domain_controller.vm_name
}

output "dc_private_ip" {
  value = module.domain_controller.private_ip_address
}

output "dc_public_ip" {
  value = module.domain_controller.public_ip_address
}

output "dc_admin_username" {
  value = module.domain_controller.admin_username
}

output "dc_admin_password" {
  description = "Retrieve with: terraform output -raw dc_admin_password"
  value       = random_password.dc_admin.result
  sensitive   = true
}

output "dc_domain_name" {
  value = module.domain_controller.domain_name
}
