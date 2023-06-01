---
subcategory: "Outposts"
layout: "aws"
page_title: "AWS: aws_outposts_assets"
description: |-
  Information about hardware assets in an Outpost.
---

# Data Source: aws_outposts_assets

Information about hardware assets in an Outpost.

## Example Usage

### Basic

```terraform
data "aws_outposts_assets" "example" {
  arn = data.aws_outposts_outpost.example.arn
}
```

### With Host ID Filter

```terraform
data "aws_outposts_assets" "example" {
  arn            = data.aws_outposts_outpost.example.arn
  host_id_filter = ["h-x38g5n0yd2a0ueb61"]
}
```

### With Status ID Filter

```terraform
data "aws_outposts_assets" "example" {
  arn              = data.aws_outposts_outpost.example.arn
  status_id_filter = ["ACTIVE"]
}
```

## Argument Reference

The following arguments are supported:

* `arn` - (Required) Outpost ARN.
* `hostIdFilter` - (Optional) Filters by list of Host IDs of a Dedicated Host.
* `statusIdFilter` - (Optional) Filters by list of state status. Valid values: "ACTIVE", "RETIRING".

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `assetIds` - List of all the asset ids found. This data source will fail if none are found.

<!-- cache-key: cdktf-0.17.0-pre.15 input-b1dd9b03b33a19e2dc65f2e22b78481764f82f245f607dac5938cd944d35d74f -->