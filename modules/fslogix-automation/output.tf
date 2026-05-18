output "automation_account_name" {
  value = azurerm_automation_account.this.name
}

output "automation_account_id" {
  value = azurerm_automation_account.this.id
}

output "automation_account_identity_principal_id" {
  value = azurerm_automation_account.this.identity[0].principal_id
}

output "hybrid_worker_group_name" {
  value = azurerm_automation_hybrid_runbook_worker_group.this.name
}

output "hybrid_service_url" {
  value = azurerm_automation_account.this.hybrid_service_url
}
