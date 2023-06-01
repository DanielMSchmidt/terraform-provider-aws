---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_transit_gateway_route_table_attachment"
description: |-
  Creates a transit gateway route table attachment.
---

# Resource: aws_networkmanager_transit_gateway_route_table_attachment

Creates a transit gateway route table attachment.

## Example Usage

```terraform
resource "aws_networkmanager_transit_gateway_route_table_attachment" "example" {
  peering_id                      = aws_networkmanager_transit_gateway_peering.example.id
  transit_gateway_route_table_arn = aws_ec2_transit_gateway_route_table.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `peeringId` - (Required) The ID of the peer for the attachment.
* `tags` - (Optional) Key-value tags for the attachment. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `transitGatewayRouteTableArn` - (Required) The ARN of the transit gateway route table for the attachment.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Attachment Amazon Resource Name (ARN).
* `attachmentPolicyRuleNumber` - The policy rule number associated with the attachment.
* `attachmentType` - The type of attachment.
* `coreNetworkArn` - The ARN of the core network.
* `coreNetworkId` - The ID of the core network.
* `edgeLocation` - The edge location for the peer.
* `id` - The ID of the attachment.
* `ownerAccountId` - The ID of the attachment account owner.
* `resourceArn` - The attachment resource ARN.
* `segmentName` - The name of the segment attachment.
* `state` - The state of the attachment.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerTransitGatewayRouteTableAttachment` can be imported using the attachment ID, e.g.

```
$ terraform import aws_networkmanager_transit_gateway_route_table_attachment.example attachment-0f8fa60d2238d1bd8
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-20b54cbabf54eeb09a3cb10759a53a5090e86a6a6c32257822268159a902a148 -->