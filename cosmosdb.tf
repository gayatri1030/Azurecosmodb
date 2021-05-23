
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

/*
data "azurerm_subnet" "subnet"{
  for_each             = { for i in var.cosmos_db_whitelist_subnet : i.virtual_network_name => i.virtual_network_name }
  resource_group_name  = data.azurerm_resource_group.rg.name
  name                 = lookup({for i in var.cosmos_db_whitelist_subnet: i.virtual_network_name => i.subnet_name},each.value )
  virtual_network_name = lookup({for i in var.cosmos_db_whitelist_subnet: i.virtual_network_name => i.virtual_network_name},each.value)
}

locals {
  subnet_ids = [ data.azurerm_subnet.subnet[*].id ]
}
*/

resource "azurerm_cosmosdb_account" "cosmos-db" {
  location            = var.location
  name                = var.cosmos_db_account_name == "" ? "${var.app_name}-${var.environment}" : "${var.cosmos_db_account_name}-${var.environment}"
  offer_type          = "Standard"
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = var.cosmos_db_account_kind

  dynamic "geo_location" {
    for_each = var.cosmos_db_geo_location
    content {
      failover_priority = geo_location.value["failover_priority"]
      location          = geo_location.value["location"]
    }
  }

  ip_range_filter                   = var.cosmos_db_whitelist_ips
  analytical_storage_enabled        = var.cosmos_db_enable_analytical_storage
  public_network_access_enabled     = var.cosmos_db_public_network_access_enabled
  is_virtual_network_filter_enabled = var.cosmos_db_virtual_network_filter_enabled
  mongo_server_version              = lower(var.cosmos_db_account_kind) == "mongodb" ? var.cosmos_db_mong_server_version : null
  network_acl_bypass_for_azure_services = var.cosmos_db_network_acl_bypass_enabled_for_azure_services

  backup {
    type                = var.cosmos_db_backup_type
    interval_in_minutes = lower(var.cosmos_db_backup_type) == "periodic" ? var.cosmos_db_periodic_interval_in_minutes : null
    retention_in_hours  = lower(var.cosmos_db_backup_type) == "periodic" ? var.cosmos_db_periodic_retention_in_hours  : null
  }
/*
  dynamic "virtual_network_rule" {
    for_each = local.subnet_ids
    content {
      id = virtual_network_rule.value
    }
  }
*/
  consistency_policy {
    consistency_level = var.cosmos_db_consistency_policy
  }

}



