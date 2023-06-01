---
subcategory: "Outposts"
layout: "aws"
page_title: "AWS: aws_outposts_outpost_instance_types"
description: |-
  Information about Outpost Instance Types.
---

# Data Source: aws_outposts_outpost_instance_types

Information about Outposts Instance Types.

## Example Usage

```terraform
data "aws_outposts_outpost_instance_types" "example" {
  arn = data.aws_outposts_outpost.example.arn
}
```

## Argument Reference

The following arguments are required:

* `arn` - (Required) Outpost ARN.

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `instance_types` - Set of instance types.

<!-- cache-key: cdktf-0.17.0-pre.15 input-c1cbc09a8f3f54371e6dc1138a3c0324985fe6196569dffea7daa9f0386a22d6 -->