---
subcategory: "X-Ray"
layout: "aws"
page_title: "AWS: aws_xray_sampling_rule"
description: |-
    Creates and manages an AWS XRay Sampling Rule.
---

# Resource: aws_xray_sampling_rule

Creates and manages an AWS XRay Sampling Rule.

## Example Usage

```terraform
resource "aws_xray_sampling_rule" "example" {
  rule_name      = "example"
  priority       = 10000
  version        = 1
  reservoir_size = 1
  fixed_rate     = 0.05
  url_path       = "*"
  host           = "*"
  http_method    = "*"
  service_type   = "*"
  service_name   = "*"
  resource_arn   = "*"

  attributes = {
    Hello = "Tris"
  }
}
```

## Argument Reference

* `ruleName` - (Required) The name of the sampling rule.
* `resourceArn` - (Required) Matches the ARN of the AWS resource on which the service runs.
* `priority` - (Required) The priority of the sampling rule.
* `fixedRate` - (Required) The percentage of matching requests to instrument, after the reservoir is exhausted.
* `reservoirSize` - (Required) A fixed number of matching requests to instrument per second, prior to applying the fixed rate. The reservoir is not used directly by services, but applies to all services using the rule collectively.
* `serviceName` - (Required) Matches the `name` that the service uses to identify itself in segments.
* `serviceType` - (Required) Matches the `origin` that the service uses to identify its type in segments.
* `host` - (Required) Matches the hostname from a request URL.
* `httpMethod` - (Required) Matches the HTTP method of a request.
* `urlPath` - (Required) Matches the path from a request URL.
* `version` - (Required) The version of the sampling rule format (`1` )
* `attributes` - (Optional) Matches attributes derived from the request.
* `tags` - (Optional) Key-value mapping of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The name of the sampling rule.
* `arn` - The ARN of the sampling rule.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

XRay Sampling Rules can be imported using the name, e.g.,

```
$ terraform import aws_xray_sampling_rule.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7ac2ab69fc5b3fafcab14171dbd951215bf6bddafd60f4655d820f103b661d3f -->