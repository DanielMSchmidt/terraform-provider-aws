---
subcategory: "Route 53 Resolver"
layout: "aws"
page_title: "AWS: aws_route53_resolver_rule_association"
description: |-
  Provides a Route53 Resolver rule association.
---

# Resource: aws_route53_resolver_rule_association

Provides a Route53 Resolver rule association.

## Example Usage

```terraform
resource "aws_route53_resolver_rule_association" "example" {
  resolver_rule_id = aws_route53_resolver_rule.sys.id
  vpc_id           = aws_vpc.foo.id
}
```

## Argument Reference

The following arguments are supported:

* `resolverRuleId` - (Required) The ID of the resolver rule that you want to associate with the VPC.
* `vpcId` - (Required) The ID of the VPC that you want to associate the resolver rule with.
* `name` - (Optional) A name for the association that you're creating between a resolver rule and a VPC.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the resolver rule association.

## Import

Route53 Resolver rule associations can be imported using the `id`, e.g.,

```
$ terraform import aws_route53_resolver_rule_association.example rslvr-rrassoc-97242eaf88example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-0f466c41cd22e0229bb830fef4b71a5b1fe4ce81b8733f3da992f9b7cdf86a5e -->