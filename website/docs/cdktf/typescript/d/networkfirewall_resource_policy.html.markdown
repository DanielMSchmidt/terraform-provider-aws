---
subcategory: "Network Firewall"
layout: "aws"
page_title: "AWS: aws_networkfirewall_resource_policy"
description: |-
  Retrieve information about a Network Firewall resource policy.
---

# Data Source: aws_networkfirewall_resource_policy

Retrieve information about a Network Firewall resource policy.

## Example Usage

```terraform
data "aws_networkfirewall_resource_policy" "example" {
  resource_arn = var.resource_policy_arn
}
```

## Argument Reference

* `resourceArn` - (Required) The Amazon Resource Name (ARN) that identifies the resource policy.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Resource Name (ARN) that identifies the resource policy.
* `policy` - The [policy][1] for the resource.

[1]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_resource_policy

<!-- cache-key: cdktf-0.17.0-pre.15 input-b5f94cfd16b1fdb5828f20608212a2a042d3cb42402a8792155c3a702f647a15 -->