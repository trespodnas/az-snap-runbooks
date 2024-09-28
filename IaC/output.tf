output "rg_name" {
  value       = azurerm_resource_group.aa_resource_group.name
  description = "resource group name"
}

output "rg_location" {
  value       = azurerm_resource_group.aa_resource_group.location
  description = "resource group location"
}

output "automation_account_name" {
  value       = azurerm_automation_account.automation_acct.name
  description = "automation account name"
}