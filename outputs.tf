output "id" {
  description = "The ID of the NAT Gateway."
  value       = azurerm_nat_gateway.nat.id
}

output "name" {
  description = "The Name of the NAT Gateway."
  value       = azurerm_nat_gateway.nat.name
}

output "resource_group_name" {
  description = "The Resource Group name of the NAT Gateway."
  value       = azurerm_nat_gateway.nat.resource_group_name
}
