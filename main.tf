resource "azurerm_postgresql_flexible_server" "main" {
  name                          = "${var.tenant}-${var.name}-pgsql-${var.server_name}-${var.environment}"
  resource_group_name           = var.rg_name
  location                      = var.rg_location
  create_mode                   = "Default"
  public_network_access_enabled = false
  backup_retention_days         = var.backup_retention_days
  sku_name                      = var.database_sku
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  private_dns_zone_id           = var.pgsql_prv_dns_id
  delegated_subnet_id           = var.pgsql_subnet_ids[0]
  administrator_login           = random_string.dbuser.result
  administrator_password        = random_password.dbpass.result
  version                       = var.database_version
  storage_mb                    = var.storage_mb
  storage_tier                  = var.storage_tier
  auto_grow_enabled             = var.auto_grow_enabled
  zone                          = "1"

  dynamic "high_availability" {
    for_each = (var.high_availability == true) ? [true] : []
    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = 2
    }
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability[0].standby_availability_zone
    ]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pgsql-${var.server_name}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}
