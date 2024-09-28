provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "aa_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.resource_group_tags
}

resource "azurerm_automation_account" "automation_acct" {
  name                = var.automation_account_name
  resource_group_name = azurerm_resource_group.aa_resource_group.name
  location            = azurerm_resource_group.aa_resource_group.location
  sku_name            = var.automation_account_sku
}

resource "azurerm_automation_variable_string" "az_sub_id" {
  name                    = var.runbook_env_var_az_sub_id_key
  automation_account_name = azurerm_automation_account.automation_acct.name
  resource_group_name     = azurerm_resource_group.aa_resource_group.name
  value                   = data.azurerm_subscription.current.subscription_id
  encrypted               = true
}

resource "azurerm_automation_variable_string" "snapshot_threshold" {
  name                    = var.runbook_env_var_snapshot_threshold_key
  automation_account_name = azurerm_automation_account.automation_acct.name
  resource_group_name     = azurerm_resource_group.aa_resource_group.name
  value                   = var.runbook_env_var_snapshot_threshold_value
}

resource "azurerm_automation_variable_string" "vm_resource_group_name" {
  name                    = var.runbook_env_var_vm_rg_name
  automation_account_name = azurerm_automation_account.automation_acct.name
  resource_group_name     = azurerm_resource_group.aa_resource_group.name
}

resource "azurerm_automation_variable_string" "vms_to_snapshot" {
  name                    = var.runbook_env_var_snapshot_vm_names
  automation_account_name = azurerm_automation_account.automation_acct.name
  resource_group_name     = azurerm_resource_group.aa_resource_group.name
}

module "install_pkgs" {
  source               = "./modules/pkg_mgmt"
  resource_group_name  = azurerm_resource_group.aa_resource_group.name
  automation_acct_name = azurerm_automation_account.automation_acct.name
  packages             = var.packages
}

module "create_runbooks" {
  source          = "./modules/runbook"
  aa_account_name = azurerm_automation_account.automation_acct.name
  rg_name         = azurerm_resource_group.aa_resource_group.name
  rg_location     = azurerm_resource_group.aa_resource_group.location
  runbook_properties = {
    create_snapshots_runbook = {
      name         = "create_snapshots_runbook"
      type         = "Python3"
      content_path = "${path.cwd}/../snapShotCreation/createsnapshot.py"
    }
    expire_snapshots_runbook = {
      name         = "expire_snapshots_runbook"
      type         = "Python3"
      content_path = "${path.cwd}/../snapShotExpiration/expiresnapshots.py"
    }
  }
}

module "create_runbook_schedules" {
  source                      = "./modules/runbook_schedule"
  automation_account_name     = azurerm_automation_account.automation_acct.name
  runbook_resource_group_name = azurerm_resource_group.aa_resource_group.name
  runbook_schedule_properties = {
    create_snapshot_schedule = {
      name      = "create_snapshot_schedule"
      frequency = "Week"
      week_days = ["Monday", "Wednesday", "Friday"]
    }
    expire_snapshot_schedule = {
      name       = "expire_snapshot_schedule"
      frequency  = "Month"
      month_days = [1]
    }
  }
}

module "link_schedule_to_runbooks" {
  source              = "./modules/runbook_schedule_link"
  aa_acct_name        = azurerm_automation_account.automation_acct.name
  resource_group_name = azurerm_resource_group.aa_resource_group.name
  runbook_link_properties = {
    for i in range(length(module.create_runbooks.runbook_name)) : module.create_runbooks.runbook_name[i] => {
      runbook_name  = module.create_runbooks.runbook_name[i]
      schedule_name = module.create_runbook_schedules.runbook_schedule_name[i]
    }
  }
}

