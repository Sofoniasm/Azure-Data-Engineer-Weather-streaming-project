resource "azurerm_eventhub_namespace" "this" {
  name                     = var.namespace_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  capacity                 = 1
  auto_inflate_enabled     = true
  maximum_throughput_units = 4
}

resource "azurerm_eventhub" "this" {
  name              = var.eventhub_name
  namespace_id      = azurerm_eventhub_namespace.this.id
  partition_count   = var.partition_count
  message_retention = var.message_retention
}

resource "azurerm_eventhub_namespace_authorization_rule" "send" {
  name                = "send"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
  name                = "listen"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = false
  manage              = false
}
