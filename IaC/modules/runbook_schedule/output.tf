
output "runbook_schedule_name" {
  value = [for runbook in azurerm_automation_schedule.run_schedule : runbook.name]
}