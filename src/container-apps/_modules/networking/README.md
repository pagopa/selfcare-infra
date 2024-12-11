# networking

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway_public_ip_association.selc_subnet_pip_nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.selc_pnpg_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.selc_pnpg_cae_subnet_inbound_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.selc_pnpg_cae_subnet_outbound_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet.pnpg_container_app_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.selc_container_app_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.pnpg_subnet_gateway_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.selc_subnet_gateway_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.selc_pnpg_nsg_cae_subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/nat_gateway) | data source |
| [azurerm_public_ip.pip_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_virtual_network.vnet_selc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_pnpg_cae"></a> [cidr\_subnet\_pnpg\_cae](#input\_cidr\_subnet\_pnpg\_cae) | CIDR block for PNPG ContainerAppEnvironment subnet | `string` | n/a | yes |
| <a name="input_cidr_subnet_selc_cae"></a> [cidr\_subnet\_selc\_cae](#input\_cidr\_subnet\_selc\_cae) | CIDR block for SelfCare ContainerAppEnvironment subnet | `string` | n/a | yes |
| <a name="input_pnpg_container_app_name_snet"></a> [pnpg\_container\_app\_name\_snet](#input\_pnpg\_container\_app\_name\_snet) | Name of pnpg subnet | `string` | n/a | yes |
| <a name="input_pnpg_delegation"></a> [pnpg\_delegation](#input\_pnpg\_delegation) | PNPG subnet delegation | <pre>list(object({<br/>    name                       = string<br/>    service_delegation_name    = string<br/>    service_delegation_actions = list(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "name": "Microsoft.App/environments",<br/>    "service_delegation_actions": [<br/>      "Microsoft.Network/virtualNetworks/subnets/join/action"<br/>    ],<br/>    "service_delegation_name": "Microsoft.App/environments"<br/>  }<br/>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | SelfCare prefix and short environment | `string` | n/a | yes |
| <a name="input_selc_container_app_name_snet"></a> [selc\_container\_app\_name\_snet](#input\_selc\_container\_app\_name\_snet) | Name of selc subnet | `string` | n/a | yes |
| <a name="input_selc_delegation"></a> [selc\_delegation](#input\_selc\_delegation) | PNPG subnet delegation | <pre>list(object({<br/>    name                       = string<br/>    service_delegation_name    = string<br/>    service_delegation_actions = list(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "name": "Microsoft.App/environments",<br/>    "service_delegation_actions": [<br/>      "Microsoft.Network/virtualNetworks/subnets/join/action"<br/>    ],<br/>    "service_delegation_name": "Microsoft.App/environments"<br/>  }<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_pnpg"></a> [subnet\_pnpg](#output\_subnet\_pnpg) | n/a |
| <a name="output_subnet_selfcare"></a> [subnet\_selfcare](#output\_subnet\_selfcare) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
