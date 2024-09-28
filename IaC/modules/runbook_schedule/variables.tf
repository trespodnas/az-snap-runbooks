
variable "runbook_resource_group_name" {
  type        = string
  description = "automation resource group name"
}

variable "automation_account_name" {
  type        = string
  description = "automation account name"
}

variable "runbook_schedule_properties" {
  description = "properties for runbook schedule"
  type = map(object({
    name       = string
    frequency  = string
    week_days  = optional(list(string))
    month_days = optional(list(number))
  }))
}
