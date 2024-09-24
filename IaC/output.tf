output "rg_name" {
  value = azurerm_resource_group.main-rg.name
  description = "resource group name"
}

output "rg_location" {
  value = azurerm_resource_group.main-rg.location
  description = "resource group location"
}

output "automation_account_name" {
  value = azurerm_automation_account.automation_acct.name
  description = "automation account name"
}