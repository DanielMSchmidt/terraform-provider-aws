---
subcategory: "Shield"
layout: "aws"
page_title: "AWS: aws_shield_protection"
description: |-
  Enables AWS Shield Advanced for a specific AWS resource.
---

# Resource: aws_shield_protection

Enables AWS Shield Advanced for a specific AWS resource.
The resource can be an Amazon CloudFront distribution, Elastic Load Balancing load balancer, AWS Global Accelerator accelerator, Elastic IP Address, or an Amazon Route 53 hosted zone.

## Example Usage

### Create protection

```terraform
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_eip" "example" {
  domain = "vpc"
}

resource "aws_shield_protection" "example" {
  name         = "example"
  resource_arn = "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:eip-allocation/${aws_eip.example.id}"

  tags = {
    Environment = "Dev"
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A friendly name for the Protection you are creating.
* `resourceArn` - (Required) The ARN (Amazon Resource Name) of the resource to be protected.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The unique identifier (ID) for the Protection object that is created.
* `arn` - The ARN of the Protection.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Shield protection resources can be imported by specifying their ID e.g.,

```
$ terraform import aws_shield_protection.example ff9592dc-22f3-4e88-afa1-7b29fde9669a
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b3d4c6bd0350fb1bd2e36ef97cb1b8e918489cff4081a13911fe5f1ee2d1abed -->