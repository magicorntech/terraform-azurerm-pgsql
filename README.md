# terraform-azurerm-pgsql

Magicorn made Terraform Module for Azure Provider
--
```
module "pgsql-master" {
  source           = "magicorntech/pgsql/azurerm"
  version          = "0.0.1"
  tenant           = var.tenant
  name             = var.name
  environment      = var.environment
  rg_name          = azurerm_resource_group.main.name
  rg_location      = azurerm_resource_group.main.location
  pgsql_prv_dns_id = "/subscriptions/12345678-1234-1234-1234-123456789abc/resourceGroups/magicorn-main-rg-bastion/providers/Microsoft.Network/privateDnsZones/magicorn.postgres.database.azure.com"
  pgsql_subnet_ids = module.network.pgsql_subnet_ids

  # MySQL Configuration
  server_name                  = "master"
  database_version             = "14"
  database_sku                 = "GP_Standard_D2ds_v5"
  storage_mb                   = 131072
  storage_tier                 = "P10"
  auto_grow_enabled            = true
  backup_retention_days        = 7
  high_availability            = false
  geo_redundant_backup_enabled = false
}

```