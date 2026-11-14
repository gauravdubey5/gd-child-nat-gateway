# gd-child-nat-gateway: Azure NAT Gateway Terraform Module

This child module creates and manages an Azure NAT Gateway providing outbound internet connectivity for private subnets without exposing inbound ports.

Part of the **Azure Parent–Child Infrastructure Architecture** under GitHub account `gauravdubey5`.

## Features

- Standard SKU NAT Gateway with zone allocation
- Configurable TCP idle timeout (4 to 120 minutes)
- Automated association with Public IPs (`gd-child-public-ip`)
- Automated association with Subnets (`gd-child-subnet`)
- Compatible with Terraform `>= 1.5.0` and AzureRM provider `>= 3.75.0, < 5.0.0`

## Prerequisites

- Existing Resource Group (`gd-child-rg`)
- Standard Public IP (`gd-child-public-ip`)
- Azure Subnet (`gd-child-subnet`)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the NAT Gateway (1-80 chars) | `string` | n/a | yes |
| `resource_group_name` | Name of the parent Resource Group | `string` | n/a | yes |
| `location` | Azure Region for deployment | `string` | n/a | yes |
| `sku_name` | SKU name (`Standard`) | `string` | `"Standard"` | no |
| `idle_timeout_in_minutes` | TCP idle timeout in minutes | `number` | `4` | no |
| `zones` | Availability zone list | `list(string)` | `["1"]` | no |
| `public_ip_address_ids` | List of Public IP IDs to attach | `list(string)` | `[]` | no |
| `subnet_ids` | List of Subnet IDs to attach | `list(string)` | `[]` | no |
| `tags` | Map of tags applied to the NAT Gateway | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The Resource ID of the NAT Gateway |
| `name` | The Name of the NAT Gateway |
| `resource_group_name` | The Resource Group name |

## Example Usage

```hcl
module "nat_gateway" {
  source = "git::https://github.com/gauravdubey5/gd-child-nat-gateway.git?ref=v1.0.0"

  name                  = "ngw-workload-dev-001"
  resource_group_name   = module.rg.name
  location              = module.rg.location
  public_ip_address_ids = [module.public_ip.id]
  subnet_ids            = [module.subnet["snet-workload-dev-01"].id]

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Security Considerations

- NAT Gateways prevent unsolicited inbound traffic from reaching internal workloads while giving them deterministic outbound SNAT IP addresses.

## Cost Considerations

- Standard NAT Gateway incurs an hourly base charge (~$0.045/hour, ~$32.40/month) plus data processing charges ($0.045/GB). Optional in Dev environments.

## Testing & Verification

```bash
terraform fmt -check
terraform init -backend=false
terraform validate
terraform test
```
