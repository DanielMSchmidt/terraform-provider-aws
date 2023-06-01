---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_attachment_accepter"
description: |-
  Terraform resource for managing an AWS NetworkManager Attachment Accepter.
---

# Resource: aws_networkmanager_attachment_accepter

Terraform resource for managing an AWS NetworkManager Attachment Accepter.

## Example Usage

### Example with VPC attachment

```terraform
resource "aws_networkmanager_attachment_accepter" "test" {
  attachment_id   = aws_networkmanager_vpc_attachment.vpc.id
  attachment_type = aws_networkmanager_vpc_attachment.vpc.attachment_type
}
```

### Example with site-to-site VPN attachment

```terraform
resource "aws_networkmanager_attachment_accepter" "test" {
  attachment_id   = aws_networkmanager_site_to_site_vpn_attachment.vpn.id
  attachment_type = aws_networkmanager_site_to_site_vpn_attachment.vpn.attachment_type
}
```

## Argument Reference

The following arguments are required:

- `attachmentId` - (Required) The ID of the attachment.
- `attachmentType` - The type of attachment. Valid values can be found in the [AWS Documentation](https://docs.aws.amazon.com/networkmanager/latest/APIReference/API_ListAttachments.html#API_ListAttachments_RequestSyntax)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

- `attachmentPolicyRuleNumber` - The policy rule number associated with the attachment.
- `coreNetworkArn` - The ARN of a core network.
- `coreNetworkId` - The id of a core network.
- `edgeLocation` - The Region where the edge is located.
- `ownerAccountId` - The ID of the attachment account owner.
- `resourceArn` - The attachment resource ARN.
- `segmentName` - The name of the segment attachment.
- `state` - The state of the attachment.

<!-- cache-key: cdktf-0.17.0-pre.15 input-3429d741f7945c665f880493aa04a98455f5699f16c538b741fa47e136e501b1 -->