---
subcategory: "QuickSight"
layout: "aws"
page_title: "AWS: aws_quicksight_folder_membership"
description: |-
  Terraform resource for managing an AWS QuickSight Folder Membership.
---

# Resource: aws_quicksight_folder_membership

Terraform resource for managing an AWS QuickSight Folder Membership.

## Example Usage

### Basic Usage

```terraform
resource "aws_quicksight_folder_membership" "example" {
  folder_id   = aws_quicksight_folder.example.folder_id
  member_type = "DATASET"
  member_id   = aws_quicksight_data_set.example.data_set_id
}
```

## Argument Reference

The following arguments are required:

* `folderId` - (Required, Forces new resource) Identifier for the folder.
* `memberId` - (Required, Forces new resource) ID of the asset (the dashboard, analysis, or dataset).
* `memberType` - (Required, Forces new resource) Type of the member. Valid values are `analysis`, `dashboard`, and `dataset`.

The following arguments are optional:

* `awsAccountId` - (Optional, Forces new resource) AWS account ID.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - A comma-delimited string joining AWS account ID, folder ID, member type, and member ID.

## Import

QuickSight Folder Membership can be imported using the AWS account ID, folder ID, member type, and member ID separated by commas (`,`) e.g.,

```
$ terraform import aws_quicksight_folder_membership.example 123456789012,example-folder,DATASET,example-dataset
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7f36ee8876404829de7aa081731f69c58c81f001f633841f0b64695baf9c104c -->