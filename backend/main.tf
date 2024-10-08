terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
    
  }
  backend "azurerm" {
    resource_group_name = "rg_backend_tfstate_98"
    storage_account_name = "sabetfs98vb3n7kb8pr"
    container_name = "tfstate98"
    key            = "backend.terraform.tfstate"
  }
}


provider "azurerm" {
  subscription_id = "8fe266af-9a8d-40b0-bcb6-08d23e112c60"
    features {
        key_vault {
            purge_soft_delete_on_destroy    = true
            recover_soft_deleted_key_vaults = true
    }
    }
}

resource "random_string" "random_string" {
    length = 10
    special = false
    upper = false
}

resource "azurerm_resource_group" "rg_backend" {
  name     = var.rg_backend_name
  location = var.rg_backend_location
}

resource "azurerm_storage_account" "sa_backend" {
  name                     = "${lower(var.sa_backend_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_backend.name
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc_backend"{
    name = var.sc_backend_name
    storage_account_name = azurerm_storage_account.sa_backend.name
    container_access_type =  "private"
}

data "azurerm_client_config" "current" {}

data "azurerm_client_config" "current_user" {
  # Fetches details about the current logged-in user (yourself)
}

resource "azurerm_key_vault" "kv_backend" {
  name                        = "${lower(var.kv_backend_name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg_backend.location
  resource_group_name         = azurerm_resource_group.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Delete",
      "Purge",
      "Create",
      "Import",
      "Recover",
      "Restore", 
      "Update",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover",
      "Restore",

    ]

    storage_permissions = [
      "Get",
      "Delete",
      "List",
      "Backup",
      "ListSAS",
      "Set",
      "Update",

    ]
  }
  # Access policy for your user account
  access_policy {
    tenant_id = data.azurerm_client_config.current_user.tenant_id
    object_id = "2feaa029-f2ba-475c-8c42-0a0b9714253b"
    key_permissions = [
      "Get",
      "List",
      "Delete",
      "Purge",
      "Create",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
    ]

    storage_permissions = [
      "Get",
      "Delete",
      "List",
      "Backup",
      "ListSAS",
      "Set",
      "Update",
      "GetSAS",
      "SetSAS",

    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_accesskey" {
    name = var.sa_backend_accesskey_name
    value = azurerm_storage_account.sa_backend.primary_access_key
    key_vault_id = azurerm_key_vault.kv_backend.id
}