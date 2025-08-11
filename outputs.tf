output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "function_app_url" {
  value = "https://${module.functionapp.function_app_default_hostname}"
}

output "databricks_workspace_url" {
  value = module.databricks.databricks_workspace_url
}

output "eventhub_namespace" {
  value = module.eventhub.namespace_name
}

output "eventhub_name" {
  value = module.eventhub.eventhub_name
}
