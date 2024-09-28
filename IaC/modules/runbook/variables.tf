variable "rg_name" {
  description = "resource group name"
  type        = string
}

variable "rg_location" {
  description = "resource group location"
  type        = string
}

variable "aa_account_name" {
  description = "automation account name"
  type        = string
}

variable "runbook_properties" {
  description = "properties for runbook"
  type = map(object({
    name         = string
    type         = string
    content_path = string
  }))
}
