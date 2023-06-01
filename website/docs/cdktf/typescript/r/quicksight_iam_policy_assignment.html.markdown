---
subcategory: "QuickSight"
layout: "aws"
page_title: "AWS: aws_quicksight_iam_policy_assignment"
description: |-
  Terraform resource for managing an AWS QuickSight IAM Policy Assignment.
---

# Resource: aws_quicksight_iam_policy_assignment

Terraform resource for managing an AWS QuickSight IAM Policy Assignment.

## Example Usage

### Basic Usage

```terraform
resource "aws_quicksight_iam_policy_assignment" "example" {
  assignment_name   = "example"
  assignment_status = "ENABLED"
  policy_arn        = aws_iam_policy.example.arn
  identities {
    user = [aws_quicksight_user.example.user_name]
  }
}
```

## Argument Reference

The following arguments are required:

* `assignmentName` - (Required) Name of the assignment.
* `assignmentStatus` - (Required) Status of the assignment. Valid values are `enabled`, `disabled`, and `draft`.

The following arguments are optional:

* `awsAccountId` - (Optional) AWS account ID.
* `identities` - (Optional) Amazon QuickSight users, groups, or both to assign the policy to. See [`identities`](#identities).
* `namespace` - (Optional) Namespace that contains the assignment. Defaults to `default`.
* `policyArn` - (Optional) ARN of the IAM policy to apply to the Amazon QuickSight users and groups specified in this assignment.

### identities

* `groups` - (Optional) Array of Quicksight group names to assign the policy to.
* `user` - (Optional) Array of Quicksight user names to assign the policy to.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `assignmentId` - Assignment ID.
* `id` - A comma-delimited string joining AWS account ID, namespace, and assignment name.

## Import

QuickSight IAM Policy Assignment can be imported using the AWS account ID, namespace, and assignment name separated by commas (`,`) e.g.,

```
$ terraform import aws_quicksight_iam_policy_assignment.example 123456789012,default,example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-a5cc6992ae1a6c817ee69c5aae15dddef3d09a958995a328abe88deaf688ead7 -->