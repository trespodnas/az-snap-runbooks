
# resource "azurerm_resource_group" "automation_acct_rg" {
#   name     = var.rg_name
#   location = var.rg_location
# }



# data "local_file" "snapshot_create_runbook" {
#   filename = "${path.cwd}/../snapShotCreation/createsnapshot.py"
# }

resource "azurerm_automation_runbook" "py_snapshot_create_runbook" {
  name                    = var.runbook_name
  automation_account_name = var.aa_account_name
  resource_group_name     = var.rg_name
  location                = var.rg_location
  log_progress            = false
  log_verbose             = false
  runbook_type            = var.runbook_type
  content = var.runbook_content_path
#   depends_on = [azurerm_automation_account.automation_acct]
}