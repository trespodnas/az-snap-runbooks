
resource "azurerm_automation_schedule" "run_schedule" {
  for_each                = var.runbook_schedule_properties
  name                    = each.value.name
  resource_group_name     = var.runbook_resource_group_name
  automation_account_name = var.automation_account_name
  frequency               = each.value.frequency
  week_days               = each.value.week_days
  month_days              = each.value.month_days
}