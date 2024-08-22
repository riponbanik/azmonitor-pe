
output "ampls_id" {
  description = "Azure Monitor Private Link Scope Id"
  value       = azurerm_monitor_private_link_scope.this.id
}

output "ampls_name" {
  description = "Azure Monitor Private Link Scope Name"
  value       = azurerm_monitor_private_link_scope.this.name
}
