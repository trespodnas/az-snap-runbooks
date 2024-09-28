resource "azurerm_automation_python3_package" "pkg_mgmt" {
  for_each = { for pkg in var.packages : pkg.name => pkg }

  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_acct_name
  name                    = each.value.name
  content_uri             = each.value.content_uri
}