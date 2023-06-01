---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_transit_virtual_interface"
description: |-
  Provides a Direct Connect transit virtual interface resource.
---

# Resource: aws_dx_transit_virtual_interface

Provides a Direct Connect transit virtual interface resource.
A transit virtual interface is a VLAN that transports traffic from a [Direct Connect gateway](dx_gateway.html) to one or more [transit gateways](ec2_transit_gateway.html).

## Example Usage

```terraform
resource "aws_dx_gateway" "example" {
  name            = "tf-dxg-example"
  amazon_side_asn = 64512
}

resource "aws_dx_transit_virtual_interface" "example" {
  connection_id = aws_dx_connection.example.id

  dx_gateway_id  = aws_dx_gateway.example.id
  name           = "tf-transit-vif-example"
  vlan           = 4094
  address_family = "ipv4"
  bgp_asn        = 65352
}
```

## Argument Reference

The following arguments are supported:

* `addressFamily` - (Required) The address family for the BGP peer. `ipv4 ` or `ipv6`.
* `bgpAsn` - (Required) The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration.
* `connectionId` - (Required) The ID of the Direct Connect connection (or LAG) on which to create the virtual interface.
* `dxGatewayId` - (Required) The ID of the Direct Connect gateway to which to connect the virtual interface.
* `name` - (Required) The name for the virtual interface.
* `vlan` - (Required) The VLAN ID.
* `amazonAddress` - (Optional) The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers.
* `bgpAuthKey` - (Optional) The authentication key for BGP configuration.
* `customerAddress` - (Optional) The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers.
* `mtu` - (Optional) The maximum transmission unit (MTU) is the size, in bytes, of the largest permissible packet that can be passed over the connection.
The MTU of a virtual transit interface can be either `1500` or `8500` (jumbo frames). Default is `1500`.
* `sitelinkEnabled` - (Optional) Indicates whether to enable or disable SiteLink.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the virtual interface.
* `arn` - The ARN of the virtual interface.
* `awsDevice` - The Direct Connect endpoint on which the virtual interface terminates.
* `jumboFrameCapable` - Indicates whether jumbo frames (8500 MTU) are supported.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `10M`)
- `update` - (Default `10M`)
- `delete` - (Default `10M`)

## Import

Direct Connect transit virtual interfaces can be imported using the `vif id`, e.g.,

```
$ terraform import aws_dx_transit_virtual_interface.test dxvif-33cc44dd
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-d94c52523c484c226913ac555602989e9135f67c4489a8804c44d66fbf62e7d6 -->