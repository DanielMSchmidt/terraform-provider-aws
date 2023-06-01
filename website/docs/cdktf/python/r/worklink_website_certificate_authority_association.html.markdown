---
subcategory: "WorkLink"
layout: "aws"
page_title: "AWS: aws_worklink_website_certificate_authority_association"
description: |-
  Provides a AWS WorkLink Website Certificate Authority Association resource.
---

# Resource: aws_worklink_website_certificate_authority_association

## Example Usage

```terraform
resource "aws_worklink_fleet" "example" {
  name = "terraform-example"
}

resource "aws_worklink_website_certificate_authority_association" "test" {
  fleet_arn   = aws_worklink_fleet.test.arn
  certificate = file("certificate.pem")
}
```

## Argument Reference

The following arguments are supported:

* `fleet_arn` - (Required, ForceNew) The ARN of the fleet.
* `certificate` - (Required, ForceNew) The root certificate of the Certificate Authority.
* `display_name` - (Optional, ForceNew) The certificate name to display.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `website_ca_id` - A unique identifier for the Certificate Authority.

## Import

WorkLink Website Certificate Authority can be imported using `FLEET-ARN,WEBSITE-CA-ID`, e.g.,

```
$ terraform import aws_worklink_website_certificate_authority_association.example arn:aws:worklink::123456789012:fleet/example,abcdefghijk
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7583625f138d9934b95a0d214b7f282ebb3d9060bb467849ac487c8ec4d70398 -->