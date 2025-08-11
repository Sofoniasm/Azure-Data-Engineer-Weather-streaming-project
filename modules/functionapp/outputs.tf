output "function_app_id" {
  value = azurerm_linux_function_app.this.id
}

output "function_app_default_hostname" {
  value = azurerm_linux_function_app.this.default_hostname
}

output "principal_id" {
  description = "System-assigned managed identity principal ID"
  value       = azurerm_linux_function_app.this.identity[0].principal_id
}
