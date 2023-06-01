---
subcategory: "Audit Manager"
layout: "aws"
page_title: "AWS: aws_auditmanager_assessment"
description: |-
  Terraform resource for managing an AWS Audit Manager Assessment.
---

# Resource: aws_auditmanager_assessment

Terraform resource for managing an AWS Audit Manager Assessment.

## Example Usage

### Basic Usage

```terraform
resource "aws_auditmanager_assessment" "test" {
  name = "example"

  assessment_reports_destination {
    destination      = "s3://${aws_s3_bucket.test.id}"
    destination_type = "S3"
  }

  framework_id = aws_auditmanager_framework.test.id

  roles {
    role_arn  = aws_iam_role.test.arn
    role_type = "PROCESS_OWNER"
  }

  scope {
    aws_accounts {
      id = data.aws_caller_identity.current.account_id
    }
    aws_services {
      service_name = "S3"
    }
  }
}
```

## Argument Reference

The following arguments are required:

* `name` - (Required) Name of the assessment.
* `assessmentReportsDestination` - (Required) Assessment report storage destination configuration. See [`assessmentReportsDestination`](#assessment_reports_destination) below.
* `frameworkId` - (Required) Unique identifier of the framework the assessment will be created from.
* `roles` - (Required) List of roles for the assessment. See [`roles`](#roles) below.
* `scope` - (Required) Amazon Web Services accounts and services that are in scope for the assessment. See [`scope`](#scope) below.

The following arguments are optional:

* `description` - (Optional) Description of the assessment.
* `tags` - (Optional) A map of tags to assign to the assessment. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### assessment_reports_destination

* `destination` - (Required) Destination of the assessment report. This value be in the form `s3://{bucketName}`.
* `destinationType` - (Required) Destination type. Currently, `s3` is the only valid value.

### roles

* `roleArn` - (Required) Amazon Resource Name (ARN) of the IAM role.
* `roleType` - (Required) Type of customer persona. For assessment creation, type must always be `processOwner`.

### scope

* `awsAccounts` - Amazon Web Services accounts that are in scope for the assessment. See [`awsAccounts`](#aws_accounts) below.
* `awsServices` - Amazon Web Services services that are included in the scope of the assessment. See [`awsServices`](#aws_services) below.

### aws_accounts

* `id` - (Required) Identifier for the Amazon Web Services account.

### aws_services

* `serviceName` - (Required) Name of the Amazon Web Service.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the assessment.
* `id` - Unique identifier for the assessment.
* `rolesAll` - Complete list of all roles with access to the assessment. This includes both roles explicitly configured via the `roles` block, and any roles which have access to all Audit Manager assessments by default.
* `status` - Status of the assessment. Valid values are `active` and `inactive`.

## Import

Audit Manager Assessments can be imported using the assessment `id`, e.g.,

```
$ terraform import aws_auditmanager_assessment.example abc123-de45
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-3b6a0df2234a7aabc11c5ce3c0f879564a87098a84d5b3f73551a545f693abc6 -->