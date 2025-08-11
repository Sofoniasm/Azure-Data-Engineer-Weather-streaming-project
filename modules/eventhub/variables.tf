variable "namespace_name" {
  description = "Event Hub namespace name"
  type        = string
}

variable "eventhub_name" {
  description = "Event Hub name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "Namespace SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "partition_count" {
  description = "Partitions for the Event Hub"
  type        = number
  default     = 2
}

variable "message_retention" {
  description = "Message retention in days"
  type        = number
  default     = 1
}
