---
subcategory: "Backup"
layout: "aws"
page_title: "AWS: aws_backup_selection"
description: |-
  Provides details about an AWS Backup selection.
---

# Data source: aws_backup_selection

Use this data source to get information on an existing backup selection.

## Example Usage

```terraform
data "aws_backup_selection" "example" {
  plan_id      = data.aws_backup_plan.example.id
  selection_id = "selection-id-example"
}
```

## Argument Reference

The following arguments are supported:

* `planId` - (Required) Backup plan ID associated with the selection of resources.
* `selectionId` - (Required) Backup selection ID.

## Attributes Reference

In addition to all arguments above, the following attributes are available:

* `name` - Display name of a resource selection document.
* `iamRoleArn` - ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. See the [AWS Backup Developer Guide](https://docs.aws.amazon.com/aws-backup/latest/devguide/access-control.html#managed-policies) for additional information about using AWS managed policies or creating custom policies attached to the IAM role.
* `resources` - An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan..

<!-- cache-key: cdktf-0.17.0-pre.15 input-93cc07cdf2747dc64922fa671a97058b9694a71799583cbf8ecc0af9dd122d7e -->