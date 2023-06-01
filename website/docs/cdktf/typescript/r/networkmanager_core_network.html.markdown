---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_core_network"
description: |-
  Provides a core network resource.
---

# Resource: aws_networkmanager_core_network

Provides a core network resource.

## Example Usage

### Basic

```terraform
resource "aws_networkmanager_core_network" "example" {
  global_network_id = aws_networkmanager_global_network.example.id
}
```

### With description

```terraform
resource "aws_networkmanager_core_network" "example" {
  global_network_id = aws_networkmanager_global_network.example.id
  description       = "example"
}
```

### With tags

```terraform
resource "aws_networkmanager_core_network" "example" {
  global_network_id = aws_networkmanager_global_network.example.id

  tags = {
    "hello" = "world"
  }
}
```

### With VPC Attachment (Single Region)

The example below illustrates the scenario where your policy document has static routes pointing to VPC attachments and you want to attach your VPCs to the core network before applying the desired policy document. Set the `createBasePolicy` argument to `true` if your core network does not currently have any `live` policies (e.g. this is the first `terraform apply` with the core network resource), since a `live` policy is required before VPCs can be attached to the core network. Otherwise, if your core network already has a `live` policy, you may exclude the `createBasePolicy` argument.

```terraform
resource "aws_networkmanager_global_network" "example" {}

data "aws_networkmanager_core_network_policy_document" "example" {
  core_network_configuration {
    asn_ranges = ["65022-65534"]

    edge_locations {
      location = "us-west-2"
    }
  }

  segments {
    name = "segment"
  }

  segment_actions {
    action  = "create-route"
    segment = "segment"
    destination_cidr_blocks = [
      "0.0.0.0/0"
    ]
    destinations = [
      aws_networkmanager_vpc_attachment.example.id,
    ]
  }
}

resource "aws_networkmanager_core_network" "example" {
  global_network_id  = aws_networkmanager_global_network.example.id
  create_base_policy = true
}

resource "aws_networkmanager_core_network_policy_attachment" "example" {
  core_network_id = aws_networkmanager_core_network.example.id
  policy_document = data.aws_networkmanager_core_network_policy_document.example.json
}

resource "aws_networkmanager_vpc_attachment" "example" {
  core_network_id = aws_networkmanager_core_network.example.id
  subnet_arns     = aws_subnet.example[*].arn
  vpc_arn         = aws_vpc.example.arn
}
```

### With VPC Attachment (Multi-Region)

The example below illustrates the scenario where your policy document has static routes pointing to VPC attachments and you want to attach your VPCs to the core network before applying the desired policy document. Set the `createBasePolicy` argument of the [`awsNetworkmanagerCoreNetwork` resource](/docs/providers/aws/r/networkmanager_core_network.html) to `true` if your core network does not currently have any `live` policies (e.g. this is the first `terraform apply` with the core network resource), since a `live` policy is required before VPCs can be attached to the core network. Otherwise, if your core network already has a `live` policy, you may exclude the `createBasePolicy` argument. For multi-region in a core network that does not yet have a `live` policy, pass a list of regions to the `awsNetworkmanagerCoreNetwork` `basePolicyRegions` argument. In the example below, `usWest2` and `usEast1` are specified in the base policy.

```terraform
resource "aws_networkmanager_global_network" "example" {}

data "aws_networkmanager_core_network_policy_document" "example" {
  core_network_configuration {
    asn_ranges = ["65022-65534"]

    edge_locations {
      location = "us-west-2"
    }

    edge_locations {
      location = "us-east-1"
    }
  }

  segments {
    name = "segment"
  }

  segments {
    name = "segment2"
  }

  segment_actions {
    action  = "create-route"
    segment = "segment"
    destination_cidr_blocks = [
      "10.0.0.0/16"
    ]
    destinations = [
      aws_networkmanager_vpc_attachment.example_us_west_2.id,
    ]
  }

  segment_actions {
    action  = "create-route"
    segment = "segment"
    destination_cidr_blocks = [
      "10.1.0.0/16"
    ]
    destinations = [
      aws_networkmanager_vpc_attachment.example_us_east_1.id,
    ]
  }
}

resource "aws_networkmanager_core_network" "example" {
  global_network_id   = aws_networkmanager_global_network.example.id
  base_policy_regions = ["us-west-2", "us-east-1"]
  create_base_policy  = true
}

resource "aws_networkmanager_core_network_policy_attachment" "example" {
  core_network_id = aws_networkmanager_core_network.example.id
  policy_document = data.aws_networkmanager_core_network_policy_document.example.json
}

resource "aws_networkmanager_vpc_attachment" "example_us_west_2" {
  core_network_id = aws_networkmanager_core_network.example.id
  subnet_arns     = aws_subnet.example_us_west_2[*].arn
  vpc_arn         = aws_vpc.example_us_west_2.arn
}

resource "aws_networkmanager_vpc_attachment" "example_us_east_1" {
  provider = "alternate"

  core_network_id = aws_networkmanager_core_network.example.id
  subnet_arns     = aws_subnet.example_us_east_1[*].arn
  vpc_arn         = aws_vpc.example_us_east_1.arn
}
```

## Argument Reference

The following arguments are supported:

* `description` - (Optional) Description of the Core Network.
* `basePolicyRegion` - (Optional, **Deprecated** use the `basePolicyRegions` argument instead) The base policy created by setting the `createBasePolicy` argument to `true` requires a region to be set in the `edgeLocations`, `location` key. If `basePolicyRegion` is not specified, the region used in the base policy defaults to the region specified in the `provider` block.
* `basePolicyRegions` - (Optional) A list of regions to add to the base policy. The base policy created by setting the `createBasePolicy` argument to `true` requires one or more regions to be set in the `edgeLocations`, `location` key. If `basePolicyRegions` is not specified, the region used in the base policy defaults to the region specified in the `provider` block.
* `createBasePolicy` - (Optional) Specifies whether to create a base policy when a core network is created or updated. A base policy is created and set to `live` to allow attachments to the core network (e.g. VPC Attachments) before applying a policy document provided using the [`awsNetworkmanagerCoreNetworkPolicyAttachment` resource](/docs/providers/aws/r/networkmanager_core_network_policy_attachment.html). This base policy is needed if your core network does not have any `live` policies and your policy document has static routes pointing to VPC attachments and you want to attach your VPCs to the core network before applying the desired policy document. Valid values are `true` or `false`. An example of this Terraform snippet can be found above [for VPC Attachment in a single region](#with-vpc-attachment-single-region) and [for VPC Attachment multi-region](#with-vpc-attachment-multi-region). An example base policy is shown below. This base policy is overridden with the policy that you specify in the [`awsNetworkmanagerCoreNetworkPolicyAttachment` resource](/docs/providers/aws/r/networkmanager_core_network_policy_attachment.html).

```json
{
  "version": "2021.12",
  "core-network-configuration": {
    "asn-ranges": [
      "64512-65534"
    ],
    "vpn-ecmp-support": false,
    "edge-locations": [
      {
        "location": "us-east-1"
      }
    ]
  },
  "segments": [
    {
      "name": "segment",
      "description": "base-policy",
      "isolate-attachments": false,
      "require-attachment-acceptance": false
    }
  ]
}
```

* `globalNetworkId` - (Required) The ID of the global network that a core network will be a part of.
* `tags` - (Optional) Key-value tags for the Core Network. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `delete` - (Default `30M`)
* `update` - (Default `30M`)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Core Network Amazon Resource Name (ARN).
* `createdAt` - Timestamp when a core network was created.
* `edges` - One or more blocks detailing the edges within a core network. [Detailed below](#edges).
* `id` - Core Network ID.
* `segments` - One or more blocks detailing the segments within a core network. [Detailed below](#segments).
* `state` - Current state of a core network.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

### `edges`

The `edges` configuration block supports the following arguments:

* `asn` - ASN of a core network edge.
* `edgeLocation` - Region where a core network edge is located.
* `insideCidrBlocks` - Inside IP addresses used for core network edges.

### `segments`

The `segments` configuration block supports the following arguments:

* `edgeLocations` - Regions where the edges are located.
* `name` - Name of a core network segment.
* `sharedSegments` - Shared segments of a core network.

## Import

`awsNetworkmanagerCoreNetwork` can be imported using the core network ID, e.g.

```
$ terraform import aws_networkmanager_core_network.example core-network-0d47f6t230mz46dy4
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-685464b45b287cefb8e34a65bd6c9c66846471e7c583c76ceabc013c2addb672 -->