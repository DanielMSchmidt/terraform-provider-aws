---
subcategory: "Organizations"
layout: "aws"
page_title: "AWS: aws_organizations_policy"
description: |-
  Terraform data source for managing an AWS Organizations Policy.
---

# Data Source: aws_organizations_policy

Terraform data source for managing an AWS Organizations Policy.

## Example Usage

### Basic Usage

```terraform
data "aws_organizations_organization" "current" {}

data "aws_organizations_oorganizational_policies" "current" {
  target_id = data.aws_organizations_organization.current.roots[0].id
  filter    = "SERVICE_CONTROL_POLICY"
}
data "aws_organizational_policies" "test" {
  policy_id = data.aws_organizations_organizational_policies.current.policies[0].id
}
```

## Argument Reference

The following arguments are required:

* `policyId` - (Required) The unique identifier (ID) of the policy that you want more details on. Policy id starts with a "p-" followed by 8-28 lowercase or uppercase letters, digits, and underscores.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name of the policy.
* `awsManaged` - Indicates if a policy is an AWS managed policy.
* `content` - The text content of the policy.
* `description` - The description of the policy.
* `name` - The friendly name of the policy.
* `type` - The type of policy values can be `SERVICE_CONTROL_POLICY | TAG_POLICY | BACKUP_POLICY | AISERVICES_OPT_OUT_POLICY`

<!-- cache-key: cdktf-0.17.0-pre.15 input-da3498b1f74df4212a65a9e8cbb163a9951f6fa2335a1a6552818b3c8aedc212 -->