variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the Databricks workspace"
  type        = string
}

variable "sku" {
  description = "SKU for the Databricks workspace"
  type        = string
  default     = "standard"
}
