mock_provider "azurerm" {}

run "verify_nat_gateway_plan" {
  command = plan

  variables {
    name                = "ngw-test-unit-001"
    resource_group_name = "rg-test-nat"
    location            = "eastus2"
    sku_name            = "Standard"
    zones               = ["1"]
    public_ip_address_ids = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-nat/providers/Microsoft.Network/publicIPAddresses/pip-test"
    ]
    subnet_ids = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-nat/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
    ]
    tags = {
      Environment = "test"
    }
  }

  assert {
    condition     = azurerm_nat_gateway.nat.name == "ngw-test-unit-001"
    error_message = "NAT Gateway name did not match expected value"
  }

  assert {
    condition     = length(azurerm_nat_gateway_public_ip_association.pip_assoc) == 1
    error_message = "Public IP association should be planned"
  }

  assert {
    condition     = length(azurerm_subnet_nat_gateway_association.subnet_assoc) == 1
    error_message = "Subnet association should be planned"
  }
}
