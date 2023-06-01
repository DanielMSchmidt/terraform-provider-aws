---
subcategory: "Audit Manager"
layout: "aws"
page_title: "AWS: aws_auditmanager_assessment_report"
description: |-
  Terraform resource for managing an AWS Audit Manager Assessment Report.
---

# Resource: aws_auditmanager_assessment_report

Terraform resource for managing an AWS Audit Manager Assessment Report.

## Example Usage

### Basic Usage

```terraform
resource "aws_auditmanager_assessment_report" "test" {
  name          = "example"
  assessment_id = aws_auditmanager_assessment.test.id
}
```

## Argument Reference

The following arguments are required:

* `name` - (Required) Name of the assessment report.
* `assessmentId` - (Required) Unique identifier of the assessment to create the report from.

The following arguments are optional:

* `description` - (Optional) Description of the assessment report.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `author` - Name of the user who created the assessment report.
* `id` - Unique identifier for the assessment report.
* `status` - Current status of the specified assessment report. Valid values are `complete`, `inProgress`, and `failed`.

## Import

Audit Manager Assessment Reports can be imported using the assessment report `id`, e.g.,

```
$ terraform import aws_auditmanager_assessment_report.example abc123-de45
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-e1679d78cdaefa1093d8c01e99f57d8c8d2b76b80a82e6822d654bf757a09e8a -->