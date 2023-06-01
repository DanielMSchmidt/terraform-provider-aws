---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_site_to_site_vpn_attachment"
description: |-
  Terraform resource for managing an AWS NetworkManager SiteToSiteAttachment.
---

# Resource: aws_networkmanager_site_to_site_vpn_attachment

Terraform resource for managing an AWS NetworkManager SiteToSiteAttachment.

## Example Usage

### Basic Usage

```terraform
resource "aws_networkmanager_site_to_site_vpn_attachment" "example" {
  core_network_id    = awscc_networkmanager_core_network.example.id
  vpn_connection_arn = aws_vpn_connection.example.arn
}
```

### Full Usage

```terraform
resource "aws_customer_gateway" "test" {
  bgp_asn    = 65000
  ip_address = "172.0.0.1"
  type       = "ipsec.1"
}
resource "aws_vpn_connection" "test" {
  customer_gateway_id = aws_customer_gateway.test.id
  type                = "ipsec.1"
  tags = {
    Name = "test"
  }
}
resource "aws_networkmanager_global_network" "test" {
  tags = {
    Name = "test"
  }
}
resource "awscc_networkmanager_core_network" "test" {
  global_network_id = aws_networkmanager_global_network.test.id
  policy_document   = jsonencode(jsondecode(data.aws_networkmanager_core_network_policy_document.test.json))
}
data "aws_networkmanager_core_network_policy_document" "test" {
  core_network_configuration {
    vpn_ecmp_support = false
    asn_ranges       = ["64512-64555"]
    edge_locations {
      location = data.aws_region.current.name
      asn      = 64512
    }
  }
  segments {
    name                          = "shared"
    description                   = "SegmentForSharedServices"
    require_attachment_acceptance = true
  }
  segment_actions {
    action     = "share"
    mode       = "attachment-route"
    segment    = "shared"
    share_with = ["*"]
  }
  attachment_policies {
    rule_number     = 1
    condition_logic = "or"
    conditions {
      type     = "tag-value"
      operator = "equals"
      key      = "segment"
      value    = "shared"
    }
    action {
      association_method = "constant"
      segment            = "shared"
    }
  }
}

resource "aws_networkmanager_site_to_site_vpn_attachment" "test" {
  core_network_id    = awscc_networkmanager_core_network.test.id
  vpn_connection_arn = aws_vpn_connection.test.arn
  tags = {
    segment = "shared"
  }
}
resource "aws_networkmanager_attachment_accepter" "test" {
  attachment_id   = aws_networkmanager_site_to_site_vpn_attachment.test.id
  attachment_type = aws_networkmanager_site_to_site_vpn_attachment.test.attachment_type
}
```

## Argument Reference

The following arguments are required:

- `coreNetworkId` - (Required) The ID of a core network for the VPN attachment.
- `vpnConnectionArn` - (Required) The ARN of the site-to-site VPN connection.

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

`awsNetworkmanagerSiteToSiteVpnAttachment` can be imported using the attachment ID, e.g.

```
$ terraform import aws_networkmanager_site_to_site_vpn_attachment.example attachment-0f8fa60d2238d1bd8
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-6e426129200deb6212d34810d628a30290ca28b57e1c4e317cf06f1803e87fdc -->