
resource "azurerm_automation_job_schedule" "link_schedule" {
  for_each                = var.runbook_link_properties
  automation_account_name = var.aa_acct_name
  resource_group_name     = var.resource_group_name
  runbook_name            = each.value.runbook_name
  schedule_name           = each.value.schedule_name
}