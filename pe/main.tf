
# Private Link Scope
resource "azurerm_monitor_private_link_scope" "this" {
  name                  = "ampls-${var.name}"
  resource_group_name   = var.resource_group_name
  ingestion_access_mode = var.ingestion_access_mode
  query_access_mode     = var.query_access_mode
  tags                  = var.tags
}

resource "azurerm_monitor_private_link_scoped_service" "this" {
  for_each            = { for idx, svc in var.service_ids : tostring(idx) => svc }
  name                = "svc-${each.value}-ampls"
  resource_group_name = var.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = each.value
}

# Private DNS Zones
resource "azurerm_private_dns_zone" "this" {
  for_each            = var.create_dns_zone ? local.private_dns_zones_names : []
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Private Endpoint
resource "azurerm_private_endpoint" "this" {
  name                = "pe-${var.name}-ampls"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = var.create_dns_zone ? [for _, v in azurerm_private_dns_zone.this : v.id] : var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = "psc-${var.name}-ampls"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_monitor_private_link_scope.this.id
    subresource_names              = ["azuremonitor"]
  }
  tags = var.tags
}
