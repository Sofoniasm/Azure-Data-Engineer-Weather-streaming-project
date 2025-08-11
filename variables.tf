variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
  default     = "weather"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "weather"
}

variable "location" {
  description = "Azure region for the Function App"
  type        = string
  default     = "East US"
}

variable "function_location" {
  description = "Azure region for the Function App module"
  type        = string
  default     = "East US 2"
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