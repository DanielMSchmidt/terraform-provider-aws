---
subcategory: "Route 53 Resolver"
layout: "aws"
page_title: "AWS: aws_route53_resolver_firewall_rules"
description: |-
    Provides details about rules in a specific Route53 Resolver Firewall rule group.
---

# Data Source: aws_route53_resolver_firewall_rules

`awsRoute53ResolverFirewallRules` Provides details about rules in a specific Route53 Resolver Firewall rule group.

## Example Usage

The following example shows how to get Route53 Resolver Firewall rules based on its associated firewall group id.

```terraform
data "aws_route53_resolver_firewall_rules" "example" {
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.example.id
}
```

## Argument Reference

The arguments of this data source act as filters for querying the available resolver rules in the current region.
The given filters must match exactly one resolver rule whose data will be exported as attributes.

* `firewallRuleGroupId` - (Required) The unique identifier of the firewall rule group that you want to retrieve the rules for.
* `action` - (Optional) The action that DNS Firewall should take on a DNS query when it matches one of the domains in the rule's domain list.
* `priority` - (Optional) The setting that determines the processing order of the rules in a rule group.

## Attributes Reference

* `firewallRules` - List with information about the firewall rules. See details below.

### provisioning_artifact_details

* `blockOverrideDnsType` - The DNS record's type.
* `blockOverrideDomain` - The custom DNS record to send back in response to the query.
* `blockOverrideTtl` - The recommended amount of time, in seconds, for the DNS resolver or web browser to cache the provided override record.
* `blockResponse` - The way that you want DNS Firewall to block the request.
* `creationTime` - The date and time that the rule was created, in Unix time format and Coordinated Universal Time (UTC).
* `creatorRequestId` - A unique string defined by you to identify the request.
* `firewallDomainListId` - The ID of the domain list that's used in the rule.
* `modificationTime` - The date and time that the rule was last modified, in Unix time format and Coordinated Universal Time (UTC).
* `name` - The name of the rule.

<!-- cache-key: cdktf-0.17.0-pre.15 input-fb1f3d939985dce22c1bc0f4c0103a7577aa23dd7e24c829780067abfe3fe9e0 -->