
variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "automation_acct_name" {
  type        = string
  description = "automation account name"
}

variable "packages" {
  description = "list of python packages"
  type = list(object({
    name           = string
    content_uri    = string
    hash_algorithm = string
    hash_value     = string
  }))
}