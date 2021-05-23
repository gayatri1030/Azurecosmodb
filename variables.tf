variable "resource_group_name" {
  type       = string
  description = "The Azure resource group where the cosmos db account "
}

variable "app_name" {
  type = string
  default = ""
}

variable "location" {
  type = string
  description = "The Axure resrouce location"
}

variable "environment" {
  type = string
}

variable "cosmos_db_account_name" {
  type  = string
  default = ""
}

variable "cosmos_db_account_kind" {
  default = ""
}

variable "cosmos_db_consistency_policy" {
  default = ""
}

variable "cosmos_db_geo_location" {
  type = list(object({
    failover_priority = number
    location = string
  }))

}

variable "cosmos_db_whitelist_ips" {
  type = string
}

variable "cosmos_db_enable_analytical_storage" {
  default = false
  type = bool
}

variable "cosmos_db_public_network_access_enabled" {
  type = bool
}

variable "cosmos_db_virtual_network_filter_enabled" {
  type = bool
  default = false
}

variable "cosmos_db_network_acl_bypass_enabled_for_azure_services" {
  default = false
  type = bool
}

variable "cosmos_db_mong_server_version" {
  type = string
}

variable "cosmos_db_periodic_interval_in_minutes" {
  type = number
}

variable "cosmos_db_periodic_retention_in_hours" {
  type = number
}

variable "cosmos_db_backup_type" {
  type = string
}

/*
variable "cosmos_db_capabilites" {
  type = string
}

/*
variable "cosmos_db_whitelist_subnet" {
  type = list(object({
    virtual_network_name = string
    subnet_name = string
  }))
}
*/