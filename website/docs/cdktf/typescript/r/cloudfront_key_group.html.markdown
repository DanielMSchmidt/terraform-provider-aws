---
subcategory: "CloudFront"
layout: "aws"
page_title: "AWS: aws_cloudfront_key_group"
description: |-
  Provides a CloudFront key group.
---

# Resource: aws_cloudfront_key_group

## Example Usage

The following example below creates a CloudFront key group.

```terraform
resource "aws_cloudfront_public_key" "example" {
  comment     = "example public key"
  encoded_key = file("public_key.pem")
  name        = "example-key"
}

resource "aws_cloudfront_key_group" "example" {
  comment = "example key group"
  items   = [aws_cloudfront_public_key.example.id]
  name    = "example-key-group"
}
```

## Argument Reference

The following arguments are supported:

* `comment` - (Optional) A comment to describe the key group..
* `items` - (Required) A list of the identifiers of the public keys in the key group.
* `name` - (Required) A name to identify the key group.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `etag` - The identifier for this version of the key group.
* `id` - The identifier for the key group.

## Import

CloudFront Key Group can be imported using the `id`, e.g.,

```
$ terraform import aws_cloudfront_key_group.example 4b4f2r1c-315d-5c2e-f093-216t50jed10f
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-590f1ccb1523531c31f4970242dd3315d56abe86064598ef338a01c3d8e5d535 -->