terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1f4920fb-b267-454b-b530-b917bad02f96"
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "databricks" {
  source                    = "./modules/databricks"
  databricks_workspace_name = "weather-databricks"
  resource_group_name       = var.resource_group_name
  location                  = var.function_location
  sku                       = "standard"
}

module "functionapp" {
  source                = "./modules/functionapp"
  function_app_name     = "weather-func-${random_string.suffix.result}"
  resource_group_name   = var.resource_group_name
  location              = var.function_location
  app_service_plan_name = "weather-func-plan"
  storage_account_name  = "weatherfuncstorage"
  app_settings = {
    EVENTHUB_NAMESPACE      = module.eventhub.namespace_name
    EVENTHUB_NAME           = module.eventhub.eventhub_name
    EVENTHUB_CONSUMER_GROUP = "$Default"
  }
}

module "eventhub" {
  source              = "./modules/eventhub"
  namespace_name      = "weather-evh-${random_string.suffix.result}"
  eventhub_name       = "weather-stream"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  partition_count     = 2
  message_retention   = 1
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = "weather-kv-${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

# Grant RBAC roles on Key Vault to the current user for keys, secrets, and certificates
resource "azurerm_role_assignment" "kv_secrets_officer" {
  scope                = module.keyvault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "kv_crypto_officer" {
  scope                = module.keyvault.id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "kv_certificates_officer" {
  scope                = module.keyvault.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}
