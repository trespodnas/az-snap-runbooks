
resource "azurerm_automation_runbook" "create_runbook" {
  for_each                = var.runbook_properties
  name                    = each.value.name
  automation_account_name = var.aa_account_name
  resource_group_name     = var.rg_name
  location                = var.rg_location
  log_progress            = false
  log_verbose             = false
  runbook_type            = each.value.type
  content                 = each.value.content_path
}