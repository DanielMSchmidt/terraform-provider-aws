---
subcategory: "VPN (Site-to-Site)"
layout: "aws"
page_title: "AWS: aws_vpn_gateway_route_propagation"
description: |-
  Requests automatic route propagation between a VPN gateway and a route table.
---

# Resource: aws_vpn_gateway_route_propagation

Requests automatic route propagation between a VPN gateway and a route table.

~> **Note:** This resource should not be used with a route table that has
the `propagatingVgws` argument set. If that argument is set, any route
propagation not explicitly listed in its value will be removed.

## Example Usage

```terraform
resource "aws_vpn_gateway_route_propagation" "example" {
  vpn_gateway_id = aws_vpn_gateway.example.id
  route_table_id = aws_route_table.example.id
}
```

## Argument Reference

The following arguments are required:

* `vpnGatewayId` - The id of the `awsVpnGateway` to propagate routes from.
* `routeTableId` - The id of the `awsRouteTable` to propagate routes into.

## Attributes Reference

No additional attributes are exported.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `2M`)
- `delete` - (Default `2M`)

<!-- cache-key: cdktf-0.17.0-pre.15 input-0ba39adf315a2c135a035d7b5d3dafb8c2ada9d38c4381b652c8063ff2f1e94a -->