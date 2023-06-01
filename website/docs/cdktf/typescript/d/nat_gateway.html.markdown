---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_nat_gateway"
description: |-
    Provides details about a specific Nat Gateway
---

# Data Source: aws_nat_gateway

Provides details about a specific Nat Gateway.

## Example Usage

```terraform
data "aws_nat_gateway" "default" {
  subnet_id = aws_subnet.public.id
}
```

Usage with tags:

```terraform
data "aws_nat_gateway" "default" {
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }
}
```

## Argument Reference

The arguments of this data source act as filters for querying the available
Nat Gateways in the current region. The given filters must match exactly one
Nat Gateway whose data will be exported as attributes.

* `id` - (Optional) ID of the specific Nat Gateway to retrieve.
* `subnetId` - (Optional) ID of subnet that the Nat Gateway resides in.
* `vpcId` - (Optional) ID of the VPC that the Nat Gateway resides in.
* `state` - (Optional) State of the NAT gateway (pending | failed | available | deleting | deleted ).
* `tags` - (Optional) Map of tags, each pair of which must exactly match
  a pair on the desired Nat Gateway.
* `filter` - (Optional) Custom filter block as described below.

More complex filters can be expressed using one or more `filter` sub-blocks,
which take the following arguments:

* `name` - (Required) Name of the field to filter by, as defined by
  [the underlying AWS API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeNatGateways.html).
* `values` - (Required) Set of values that are accepted for the given field.
  An Nat Gateway will be selected if any one of the given values matches.

## Attributes Reference

All of the argument attributes except `filter` block are also exported as
result attributes. This data source will complete the data by populating
any fields that are not included in the configuration with the data for
the selected Nat Gateway.

`addresses` are also exported with the following attributes, when they are relevant:
Each attachment supports the following:

* `allocationId` - ID of the EIP allocated to the selected Nat Gateway.
* `associationId` - The association ID of the Elastic IP address that's associated with the NAT gateway. Only available when `connectivityType` is `public`.
* `connectivityType` - Connectivity type of the NAT Gateway.
* `networkInterfaceId` - The ID of the ENI allocated to the selected Nat Gateway.
* `privateIp` - Private Ip address of the selected Nat Gateway.
* `publicIp` - Public Ip (EIP) address of the selected Nat Gateway.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `read` - (Default `20M`)

<!-- cache-key: cdktf-0.17.0-pre.15 input-f2db50f146d17dff53c4c9bbc9efada3109eb296d7e690154b2104982801cd89 -->