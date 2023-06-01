---
subcategory: "S3 (Simple Storage)"
layout: "aws"
page_title: "AWS: aws_s3_bucket_request_payment_configuration"
description: |-
  Provides an S3 bucket request payment configuration resource.
---

# Resource: aws_s3_bucket_request_payment_configuration

Provides an S3 bucket request payment configuration resource. For more information, see [Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html).

~> **NOTE:** Destroying an `awsS3BucketRequestPaymentConfiguration` resource resets the bucket's `payer` to the S3 default: the bucket owner.

## Example Usage

```terraform
resource "aws_s3_bucket_request_payment_configuration" "example" {
  bucket = aws_s3_bucket.example.id
  payer  = "Requester"
}
```

## Argument Reference

The following arguments are supported:

* `bucket` - (Required, Forces new resource) Name of the bucket.
* `expectedBucketOwner` - (Optional, Forces new resource) Account ID of the expected bucket owner.
* `payer` - (Required) Specifies who pays for the download and request fees. Valid values: `bucketOwner`, `requester`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The `bucket` or `bucket` and `expectedBucketOwner` separated by a comma (`,`) if the latter is provided.

## Import

S3 bucket request payment configuration can be imported in one of two ways.

If the owner (account ID) of the source bucket is the same account used to configure the Terraform AWS Provider,
the S3 bucket request payment configuration resource should be imported using the `bucket` e.g.,

```
$ terraform import aws_s3_bucket_request_payment_configuration.example bucket-name
```

If the owner (account ID) of the source bucket differs from the account used to configure the Terraform AWS Provider,
the S3 bucket request payment configuration resource should be imported using the `bucket` and `expectedBucketOwner` separated by a comma (`,`) e.g.,

```
$ terraform import aws_s3_bucket_request_payment_configuration.example bucket-name,123456789012
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-8dbaecaf6057fb232e1d792b8d9e051f72deca65e40fbf991dee2fb4492b67eb -->