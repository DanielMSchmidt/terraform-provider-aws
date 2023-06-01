---
subcategory: "Outposts"
layout: "aws"
page_title: "AWS: aws_outposts_asset"
description: |-
  Information about hardware assets in an Outpost.
---

# Data Source: aws_outposts_asset

Information about a specific hardware asset in an Outpost.

## Example Usage

```terraform
data "aws_outposts_assets" "example" {
  arn = data.aws_outposts_outpost.example.arn
}

data "aws_outposts_asset" "example" {
  count    = length(data.aws_outposts_assets.example.asset_ids)
  arn      = data.aws_outposts_outpost.example.arn
  asset_id = element(data.aws_outposts_assets.this.asset_ids, count.index)
}

```

## Argument Reference

The following arguments are required:

* `arn` - (Required) Outpost ARN.
* `assetId` - (Required) ID of the asset.

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `assetType` - Type of the asset.
* `hostId` - Host ID of the Dedicated Hosts on the asset, if a Dedicated Host is provisioned.
* `rackElevation` - Position of an asset in a rack measured in rack units.
* `rackId` - Rack ID of the asset.

<!-- cache-key: cdktf-0.17.0-pre.15 input-612949145e478155f2b4d41724e1a564830034333331ee3761f0a8664004909e -->