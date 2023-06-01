---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_connect_attachment"
description: |-
  Terraform resource for managing an AWS NetworkManager ConnectAttachment.
---

# Resource: aws_networkmanager_connect_attachment

Terraform resource for managing an AWS NetworkManager ConnectAttachment.

## Example Usage

### Basic Usage

```terraform
resource "aws_networkmanager_vpc_attachment" "example" {
  subnet_arns     = aws_subnet.example[*].arn
  core_network_id = awscc_networkmanager_core_network.example.id
  vpc_arn         = aws_vpc.example.arn
}

resource "aws_networkmanager_connect_attachment" "example" {
  core_network_id         = awscc_networkmanager_core_network.example.id
  transport_attachment_id = aws_networkmanager_vpc_attachment.example.id
  edge_location           = aws_networkmanager_vpc_attachment.example.edge_location
  options {
    protocol = "GRE"
  }
}
```

### Usage with attachment accepter

```terraform
resource "aws_networkmanager_vpc_attachment" "example" {
  subnet_arns     = aws_subnet.example[*].arn
  core_network_id = awscc_networkmanager_core_network.example.id
  vpc_arn         = aws_vpc.example.arn
}

resource "aws_networkmanager_attachment_accepter" "example" {
  attachment_id   = aws_networkmanager_vpc_attachment.example.id
  attachment_type = aws_networkmanager_vpc_attachment.example.attachment_type
}

resource "aws_networkmanager_connect_attachment" "example" {
  core_network_id         = awscc_networkmanager_core_network.example.id
  transport_attachment_id = aws_networkmanager_vpc_attachment.example.id
  edge_location           = aws_networkmanager_vpc_attachment.example.edge_location
  options {
    protocol = "GRE"
  }
  depends_on = [
    "aws_networkmanager_attachment_accepter.test"
  ]
}

resource "aws_networkmanager_attachment_accepter" "example2" {
  attachment_id   = aws_networkmanager_connect_attachment.example.id
  attachment_type = aws_networkmanager_connect_attachment.example.attachment_type
}
```

## Argument Reference

The following arguments are required:

- `coreNetworkId` - (Required) The ID of a core network where you want to create the attachment.
- `transportAttachmentId` - (Required) The ID of the attachment between the two connections.
- `edgeLocation` - (Required) The Region where the edge is located.
- `options` - (Required) Options for creating an attachment.

The following arguments are optional:

- `tags` - (Optional) Key-value tags for the attachment. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

- `arn` - The ARN of the attachment.
- `attachmentPolicyRuleNumber` - The policy rule number associated with the attachment.
- `attachmentType` - The type of attachment.
- `coreNetworkArn` - The ARN of a core network.
- `coreNetworkId` - The ID of a core network
- `edgeLocation` - The Region where the edge is located.
- `id` - The ID of the attachment.
- `ownerAccountId` - The ID of the attachment account owner.
- `resourceArn` - The attachment resource ARN.
- `segmentName` - The name of the segment attachment.
- `state` - The state of the attachment.
- `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerConnectAttachment` can be imported using the attachment ID, e.g.

```
$ terraform import aws_networkmanager_connect_attachment.example attachment-0f8fa60d2238d1bd8
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-0850e7e2047601bfddd3f954c71229a183241cfec3d12fb06e2bdc728885bc11 -->