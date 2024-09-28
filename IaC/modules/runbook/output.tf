output "runbook_name" {
  value       = [for runbook in azurerm_automation_runbook.create_runbook : runbook.name]
  description = "runbook name"
}