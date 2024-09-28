variable "aa_acct_name" {
  type        = string
  description = "automation account name"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "runbook_link_properties" {
  type = map(object({
    runbook_name  = string
    schedule_name = string
  }))
}
