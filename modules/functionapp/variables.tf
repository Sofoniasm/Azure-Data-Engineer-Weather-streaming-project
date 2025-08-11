variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the Function App"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "weather-func-plan"
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
  default     = "weatherfuncstorage"
}

variable "app_settings" {
  description = "Additional application settings for the Function App"
  type        = map(string)
  default     = {}
}
