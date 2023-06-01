---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_route"
description: |-
    Provides details about a specific Route
---

# Data Source: aws_route

`awsRoute` provides details about a specific Route.

This resource can prove useful when finding the resource associated with a CIDR. For example, finding the peering connection associated with a CIDR value.

## Example Usage

The following example shows how one might use a CIDR value to find a network interface id and use this to create a data source of that network interface.

```terraform
variable "subnet_id" {}

data "aws_route_table" "selected" {
  subnet_id = var.subnet_id
}

data "aws_route" "route" {
  route_table_id         = aws_route_table.selected.id
  destination_cidr_block = "10.0.1.0/24"
}

data "aws_network_interface" "interface" {
  id = data.aws_route.route.network_interface_id
}
```

## Argument Reference

The arguments of this data source act as filters for querying the available Route in the current region. The given filters must match exactly oneRoute whose data will be exported as attributes.

The following arguments are required:

* `routeTableId` - (Required) ID of the specific Route Table containing the Route entry.

The following arguments are optional:

* `carrierGatewayId` - (Optional) EC2 Carrier Gateway ID of the Route belonging to the Route Table.
* `coreNetworkArn` - (Optional) Core network ARN of the Route belonging to the Route Table.
* `destinationCidrBlock` - (Optional) CIDR block of the Route belonging to the Route Table.
* `destinationIpv6CidrBlock` - (Optional) IPv6 CIDR block of the Route belonging to the Route Table.
* `destinationPrefixListId` - (Optional) ID of a [managed prefix list](ec2_managed_prefix_list.html) destination of the Route belonging to the Route Table.
* `egressOnlyGatewayId` - (Optional) Egress Only Gateway ID of the Route belonging to the Route Table.
* `gatewayId` - (Optional) Gateway ID of the Route belonging to the Route Table.
* `instanceId` - (Optional) Instance ID of the Route belonging to the Route Table.
* `localGatewayId` - (Optional) Local Gateway ID of the Route belonging to the Route Table.
* `natGatewayId` - (Optional) NAT Gateway ID of the Route belonging to the Route Table.
* `networkInterfaceId` - (Optional) Network Interface ID of the Route belonging to the Route Table.
* `transitGatewayId` - (Optional) EC2 Transit Gateway ID of the Route belonging to the Route Table.
* `vpcPeeringConnectionId` - (Optional) VPC Peering Connection ID of the Route belonging to the Route Table.

## Attributes Reference

All of the argument attributes are also exported as result attributes when there is data available. For example, the `vpcPeeringConnectionId` field will be empty when the route is attached to a Network Interface.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `read` - (Default `20M`)

<!-- cache-key: cdktf-0.17.0-pre.15 input-6d1149e7a8f575127b55271da0d64d5857f9c654fe9e264908a4958431a7ee81 -->