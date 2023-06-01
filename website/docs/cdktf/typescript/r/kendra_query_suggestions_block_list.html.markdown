---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_query_suggestions_block_list"
description: |-
  Terraform resource for managing an AWS Kendra block list used for query suggestions for an index
---

# Resource: aws_kendra_query_suggestions_block_list

Terraform resource for managing an AWS Kendra block list used for query suggestions for an index.

## Example Usage

### Basic Usage

```terraform
resource "aws_kendra_query_suggestions_block_list" "example" {
  index_id = aws_kendra_index.example.id
  name     = "Example"
  role_arn = aws_iam_role.example.arn

  source_s3_path {
    bucket = aws_s3_bucket.example.id
    key    = "example/suggestions.txt"
  }

  tags = {
    Name = "Example Kendra Index"
  }
}
```

## Argument Reference

The following arguments are required:

* `indexId`- (Required, Forces new resource) The identifier of the index for a block list.
* `name` - (Required) The name for the block list.
* `roleArn` - (Required) The IAM (Identity and Access Management) role used to access the block list text file in S3.
* `sourceS3Path` - (Required) The S3 path where your block list text file sits in S3. Detailed below.

The `sourceS3Path` configuration block supports the following arguments:

* `bucket` - (Required) The name of the S3 bucket that contains the file.
* `key` - (Required) The name of the file.

The following arguments are optional:

* `description` - (Optional) The description for a block list.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the block list.
* `querySuggestionsBlockListId` - The unique indentifier of the block list.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

`awsKendraQuerySuggestionsBlockList` can be imported using the unique identifiers of the block list and index separated by a slash (`/`), e.g.,

```
$ terraform import aws_kendra_query_suggestions_block_list.example blocklist-123456780/idx-8012925589
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-092a44771db2ac8964ddafbb83ba40c504790780012a6c8a993238963f59632b -->