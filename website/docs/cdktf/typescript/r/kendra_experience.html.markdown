---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_experience"
description: |-
  Terraform resource for managing an AWS Kendra Experience.
---

# Resource: aws_kendra_experience

Terraform resource for managing an AWS Kendra Experience.

## Example Usage

### Basic Usage

```terraform
resource "aws_kendra_experience" "example" {
  index_id    = aws_kendra_index.example.id
  description = "My Kendra Experience"
  name        = "example"
  role_arn    = aws_iam_role.example.arn

  configuration {
    content_source_configuration {
      direct_put_content = true
      faq_ids            = [aws_kendra_faq.example.faq_id]
    }
    user_identity_configuration {
      identity_attribute_name = "12345ec453-1546651e-79c4-4554-91fa-00b43ccfa245"
    }
  }
}
```

## Argument Reference

~> **NOTE:** By default of the AWS Kendra API, updates to an existing `awsKendraExperience` resource (e.g. updating the `name`) will also update the `configurationContentSourceConfigurationDirectPutContent` parameter to `false` if not already provided.

The following arguments are required:

* `indexId` - (Required, Forces new resource) The identifier of the index for your Amazon Kendra experience.
* `name` - (Required) A name for your Amazon Kendra experience.
* `roleArn` - (Required) The Amazon Resource Name (ARN) of a role with permission to access `Query API`, `QuerySuggestions API`, `SubmitFeedback API`, and `AWS SSO` that stores your user and group information. For more information, see [IAM roles for Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).

The following arguments are optional:

* `description` - (Optional, Forces new resource if removed) A description for your Amazon Kendra experience.
* `configuration` - (Optional) Configuration information for your Amazon Kendra experience. Terraform will only perform drift detection of its value when present in a configuration. [Detailed below](#configuration).

### `configuration`

~> **NOTE:** By default of the AWS Kendra API, the `contentSourceConfigurationDirectPutContent` parameter will be set to `false` if not provided.  

The `configuration` configuration block supports the following arguments:

* `contentSourceConfiguration` - (Optional, Required if `userIdentityConfiguration` not provided) The identifiers of your data sources and FAQs. Or, you can specify that you want to use documents indexed via the `BatchPutDocument API`. Terraform will only perform drift detection of its value when present in a configuration. [Detailed below](#content_source_configuration).
* `userIdentityConfiguration` - (Optional, Required if `contentSourceConfiguration` not provided) The AWS SSO field name that contains the identifiers of your users, such as their emails. [Detailed below](#user_identity_configuration).

### `contentSourceConfiguration`

The `contentSourceConfiguration` configuration block supports the following arguments:

* `dataSourceIds` - (Optional) The identifiers of the data sources you want to use for your Amazon Kendra experience. Maximum number of 100 items.
* `directPutContent` - (Optional) Whether to use documents you indexed directly using the `BatchPutDocument API`. Defaults to `false`.
* `faqIds` - (Optional) The identifier of the FAQs that you want to use for your Amazon Kendra experience. Maximum number of 100 items.

### `userIdentityConfiguration`

The `userIdentityConfiguration` configuration block supports the following argument:

* `identityAttributeName` - (Required) The AWS SSO field name that contains the identifiers of your users, such as their emails.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The unique identifiers of the experience and index separated by a slash (`/`).
* `arn` - ARN of the Experience.
* `endpoints` - Shows the endpoint URLs for your Amazon Kendra experiences. The URLs are unique and fully hosted by AWS.
    * `endpoint` - The endpoint of your Amazon Kendra experience.
    * `endpointType` - The type of endpoint for your Amazon Kendra experience.
* `experienceId` - The unique identifier of the experience.
* `status` - The current processing status of your Amazon Kendra experience.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

Kendra Experience can be imported using the unique identifiers of the experience and index separated by a slash (`/`) e.g.,

```
$ terraform import aws_kendra_experience.example 1045d08d-66ef-4882-b3ed-dfb7df183e90/b34dfdf7-1f2b-4704-9581-79e00296845f
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-291e015638832a887e2f11d1658b1c2495fa53ba353c1eddc58115e236cbc8fc -->