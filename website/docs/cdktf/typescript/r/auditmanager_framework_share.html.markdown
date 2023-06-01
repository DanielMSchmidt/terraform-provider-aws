---
subcategory: "Audit Manager"
layout: "aws"
page_title: "AWS: aws_auditmanager_framework_share"
description: |-
  Terraform resource for managing an AWS Audit Manager Framework Share.
---

# Resource: aws_auditmanager_framework_share

Terraform resource for managing an AWS Audit Manager Framework Share.

## Example Usage

### Basic Usage

```terraform
resource "aws_auditmanager_framework_share" "example" {
  destination_account = "012345678901"
  destination_region  = "us-east-1"
  framework_id        = aws_auditmanager_framework.example.id
}
```

## Argument Reference

The following arguments are required:

* `destinationAccount` - (Required) Amazon Web Services account of the recipient.
* `destinationRegion` - (Required) Amazon Web Services region of the recipient.
* `frameworkId` - (Required) Unique identifier for the shared custom framework.

The following arguments are optional:

* `comment` - (Optional) Comment from the sender about the share request.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Unique identifier for the share request.
* `status` -  Status of the share request.

## Import

Audit Manager Framework Share can be imported using the `id`, e.g.,

```
$ terraform import aws_auditmanager_framework_share.example abcdef-123456
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-70d3d584c9aafbf6ddd3151b695750185ccb1f4c016c439e8e2b9d855c353e01 -->