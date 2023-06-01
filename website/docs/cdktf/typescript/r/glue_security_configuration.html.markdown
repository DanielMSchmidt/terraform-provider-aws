---
subcategory: "Glue"
layout: "aws"
page_title: "AWS: aws_glue_security_configuration"
description: |-
  Manages a Glue Security Configuration
---

# Resource: aws_glue_security_configuration

Manages a Glue Security Configuration.

## Example Usage

```terraform
resource "aws_glue_security_configuration" "example" {
  name = "example"

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = "DISABLED"
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = "DISABLED"
    }

    s3_encryption {
      kms_key_arn        = data.aws_kms_key.example.arn
      s3_encryption_mode = "SSE-KMS"
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `encryptionConfiguration` – (Required) Configuration block containing encryption configuration. Detailed below.
* `name` – (Required) Name of the security configuration.

### encryption_configuration Argument Reference

* `cloudwatch_encryption ` - (Required) A `cloudwatch_encryption ` block as described below, which contains encryption configuration for CloudWatch.
* `job_bookmarks_encryption ` - (Required) A `job_bookmarks_encryption ` block as described below, which contains encryption configuration for job bookmarks.
* `s3Encryption` - (Required) A `s3_encryption ` block as described below, which contains encryption configuration for S3 data.

#### cloudwatch_encryption Argument Reference

* `cloudwatchEncryptionMode` - (Optional) Encryption mode to use for CloudWatch data. Valid values: `disabled`, `sseKms`. Default value: `disabled`.
* `kmsKeyArn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

#### job_bookmarks_encryption Argument Reference

* `jobBookmarksEncryptionMode` - (Optional) Encryption mode to use for job bookmarks data. Valid values: `cseKms`, `disabled`. Default value: `disabled`.
* `kmsKeyArn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

#### s3_encryption Argument Reference

* `s3EncryptionMode` - (Optional) Encryption mode to use for S3 data. Valid values: `disabled`, `sseKms`, `sseS3`. Default value: `disabled`.
* `kmsKeyArn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Glue security configuration name

## Import

Glue Security Configurations can be imported using `name`, e.g.,

```
$ terraform import aws_glue_security_configuration.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-59f361f7f4e351e08a1b48de5e5dee27aeabf827c3f7f465760c08955c04f212 -->