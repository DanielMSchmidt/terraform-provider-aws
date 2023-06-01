---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_faq"
description: |-
  Terraform resource for managing an AWS Kendra FAQ.
---

# Resource: aws_kendra_faq

Terraform resource for managing an AWS Kendra FAQ.

## Example Usage

### Basic

```terraform
resource "aws_kendra_faq" "example" {
  index_id = aws_kendra_index.example.id
  name     = "Example"
  role_arn = aws_iam_role.example.arn

  s3_path {
    bucket = aws_s3_bucket.example.id
    key    = aws_s3_object.example.key
  }

  tags = {
    Name = "Example Kendra Faq"
  }
}
```

### With File Format

```terraform
resource "aws_kendra_faq" "example" {
  index_id    = aws_kendra_index.example.id
  name        = "Example"
  file_format = "CSV"
  role_arn    = aws_iam_role.example.arn

  s3_path {
    bucket = aws_s3_bucket.example.id
    key    = aws_s3_object.example.key
  }
}
```

### With Language Code

```terraform
resource "aws_kendra_faq" "example" {
  index_id      = aws_kendra_index.example.id
  name          = "Example"
  language_code = "en"
  role_arn      = aws_iam_role.example.arn

  s3_path {
    bucket = aws_s3_bucket.example.id
    key    = aws_s3_object.example.key
  }
}
```

## Argument Reference

The following arguments are required:

* `indexId`- (Required, Forces new resource) The identifier of the index for a FAQ.
* `name` - (Required, Forces new resource) The name that should be associated with the FAQ.
* `roleArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of a role with permission to access the S3 bucket that contains the FAQs. For more information, see [IAM Roles for Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
* `s3Path` - (Required, Forces new resource) The S3 location of the FAQ input data. Detailed below.

The `s3Path` configuration block supports the following arguments:

* `bucket` - (Required, Forces new resource) The name of the S3 bucket that contains the file.
* `key` - (Required, Forces new resource) The name of the file.

The following arguments are optional:

* `description` - (Optional, Forces new resource) The description for a FAQ.
* `fileFormat` - (Optional, Forces new resource) The file format used by the input files for the FAQ. Valid Values are `csv`, `csvWithHeader`, `json`.
* `languageCode` - (Optional, Forces new resource) The code for a language. This shows a supported language for the FAQ document. English is supported by default. For more information on supported languages, including their codes, see [Adding documents in languages other than English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the FAQ.
* `createdAt` - The Unix datetime that the FAQ was created.
* `errorMessage` - When the Status field value is `failed`, this contains a message that explains why.
* `faqId` - The identifier of the FAQ.
* `id` - The unique identifiers of the FAQ and index separated by a slash (`/`)
* `status` - The status of the FAQ. It is ready to use when the status is ACTIVE.
* `updatedAt` - The date and time that the FAQ was last updated.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

`awsKendraFaq` can be imported using the unique identifiers of the FAQ and index separated by a slash (`/`), e.g.,

```
$ terraform import aws_kendra_faq.example faq-123456780/idx-8012925589
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-0cf7fbbfe9ae3e334f6824207b7b8a5e65b4f28e9af2a9b6f2c2a54183860b61 -->