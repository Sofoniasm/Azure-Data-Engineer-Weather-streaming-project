output "namespace_name" {
  value = azurerm_eventhub_namespace.this.name
}

output "eventhub_name" {
  value = azurerm_eventhub.this.name
}

output "send_connection_string" {
  value     = azurerm_eventhub_namespace_authorization_rule.send.primary_connection_string
  sensitive = true
}

output "listen_connection_string" {
  value     = azurerm_eventhub_namespace_authorization_rule.listen.primary_connection_string
  sensitive = true
}
