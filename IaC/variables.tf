variable "subscription_id" {
  type        = string
  sensitive   = true
  description = "subscription id"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "resource group location"
}

variable "resource_group_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource group"
}


variable "automation_account_sku" {
  type        = string
  default     = "Basic"
  description = "automation account sku"
}

variable "automation_account_name" {
  type        = string
  description = "automation account name"
}

variable "runbook_env_var_az_sub_id_key" {
  type        = string
  default     = "AZURE_SUB_ID"
  description = "subscription id"
}

variable "runbook_env_var_snapshot_threshold_key" {
  type        = string
  default     = "SNAP_EXPIRE_THRESHOLD"
  description = "snapshot expiration threshold"
}

variable "runbook_env_var_snapshot_threshold_value" {
  type        = number
  description = "snapshot expiration threshold"
  default     = 90
}

variable "runbook_env_var_vm_rg_name" {
  type        = string
  default     = "VM_RG_NAME"
  description = "vms resource group name"
}

variable "runbook_env_var_snapshot_vm_names" {
  type        = string
  default     = "VM_NAMES"
  description = "comma seperated string, containing vms to snapshot"
}


variable "packages" {
  description = "list of python packages to install"
  type = list(object({
    name           = string
    content_uri    = string
    hash_algorithm = string
    hash_value     = string
  }))
}