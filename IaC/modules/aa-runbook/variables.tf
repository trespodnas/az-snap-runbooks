variable "rg_name" {
  description = "resource group name"
  type = string
}

variable "rg_location" {
  description = "resource group location"
  type = string
}

variable "aa_account_name" {
  description = "automation account name"
  type = string
}



variable "runbook_name" {
  description = "runbook name"
  type = string
}

variable "runbook_type" {
  description = "runbook type"
  type = string
  default = "Python3"
}

variable "runbook_content_path" {
  description = "Path to file containing runbook"
}
