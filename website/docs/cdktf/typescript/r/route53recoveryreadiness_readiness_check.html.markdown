---
subcategory: "Route 53 Recovery Readiness"
layout: "aws"
page_title: "AWS: aws_route53recoveryreadiness_readiness_check"
description: |-
  Provides an AWS Route 53 Recovery Readiness Readiness Check
---

# Resource: aws_route53recoveryreadiness_readiness_check

Provides an AWS Route 53 Recovery Readiness Readiness Check.

## Example Usage

```terraform
resource "aws_route53recoveryreadiness_readiness_check" "example" {
  readiness_check_name = my-cw-alarm-check
  resource_set_name    = my-cw-alarm-set
}
```

## Argument Reference

The following arguments are required:

* `readinessCheckName` - (Required) Unique name describing the readiness check.
* `resourceSetName` - (Required) Name describing the resource set that will be monitored for readiness.

The following arguments are optional:

* `tags` - (Optional) Key-value mapping of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the readiness_check
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Route53 Recovery Readiness readiness checks can be imported via the readiness check name, e.g.,

```
$ terraform import aws_route53recoveryreadiness_readiness_check.my-cw-alarm-check
```

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `delete` - (Default `5M`)

<!-- cache-key: cdktf-0.17.0-pre.15 input-c8c52e0f54a44eb970011bc96f1cba4c8a898ae09f75df1ba7675d466bdcd3dd -->