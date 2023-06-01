---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_transit_gateway_peering"
description: |-
  Creates a peering connection between an AWS Cloud WAN core network and an AWS Transit Gateway.
---

# Resource: aws_networkmanager_transit_gateway_peering

Creates a peering connection between an AWS Cloud WAN core network and an AWS Transit Gateway.

## Example Usage

```terraform
resource "aws_networkmanager_transit_gateway_peering" "example" {
  core_network_id     = awscc_networkmanager_core_network.example.id
  transit_gateway_arn = aws_ec2_transit_gateway.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `coreNetworkId` - (Required) The ID of a core network.
* `tags` - (Optional) Key-value tags for the peering. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `transitGatewayArn` - (Required) The ARN of the transit gateway for the peering request.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Peering Amazon Resource Name (ARN).
* `coreNetworkArn` - The ARN of the core network.
* `edgeLocation` - The edge location for the peer.
* `id` - Peering ID.
* `ownerAccountId` - The ID of the account owner.
* `peeringType` - The type of peering. This will be `transitGateway`.
* `resourceArn` - The resource ARN of the peer.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `transitGatewayPeeringAttachmentId` - The ID of the transit gateway peering attachment.

## Import

`awsNetworkmanagerTransitGatewayPeering` can be imported using the peering ID, e.g.

```
$ terraform import aws_networkmanager_transit_gateway_peering.example peering-444555aaabbb11223
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-ba3919bfd24e0063aae717fac195ddcefede9c42544f4c11ff20316daafa572c -->