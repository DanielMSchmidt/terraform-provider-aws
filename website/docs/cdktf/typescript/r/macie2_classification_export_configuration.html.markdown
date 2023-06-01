---
subcategory: "Macie"
layout: "aws"
page_title: "AWS: aws_macie2_classification_export_configuration"
description: |-
  Provides a resource to manage Classification Results - Export Configuration
---

# Resource: aws_macie2_classification_export_configuration

Provides a resource to manage an [Amazon Macie Classification Export Configuration](https://docs.aws.amazon.com/macie/latest/APIReference/classification-export-configuration.html).

## Example Usage

```terraform
resource "aws_macie2_account" "example" {}

resource "aws_macie2_classification_export_configuration" "example" {
  depends_on = [
    aws_macie2_account.example,
  ]
  s3_destination {
    bucket_name = aws_s3_bucket.example.bucket
    key_prefix  = "exampleprefix/"
    kms_key_arn = aws_kms_key.example.arn
  }
}
```

## Argument Reference

The following arguments are supported:

* `s3Destination` - (Required) Configuration block for a S3 Destination. Defined below

### s3_destination Configuration Block

The `s3Destination` configuration block supports the following arguments:

* `bucketName` - (Required) The Amazon S3 bucket name in which Amazon Macie exports the data classification results.
* `keyPrefix` - (Optional) The object key for the bucket in which Amazon Macie exports the data classification results.
* `kmsKeyArn` - (Required) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

Additional information can be found in the [Storing and retaining sensitive data discovery results with Amazon Macie for AWS Macie documentation](https://docs.aws.amazon.com/macie/latest/user/discovery-results-repository-s3.html).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The unique identifier (ID) of the configuration.

## Import

`awsMacie2ClassificationExportConfiguration` can be imported using the account ID and region, e.g.,

```
$ terraform import aws_macie2_classification_export_configuration.example 123456789012:us-west-2
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-ca9856d3e6c522a5f0371cfd786e5d623818748ae7bb014eb58b3e62e83c6f85 -->