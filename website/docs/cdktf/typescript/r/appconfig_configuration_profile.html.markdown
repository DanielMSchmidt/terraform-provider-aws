---
subcategory: "AppConfig"
layout: "aws"
page_title: "AWS: aws_appconfig_configuration_profile"
description: |-
  Provides an AppConfig Configuration Profile resource.
---

# Resource: aws_appconfig_configuration_profile

Provides an AppConfig Configuration Profile resource.

## Example Usage

```terraform
resource "aws_appconfig_configuration_profile" "example" {
  application_id = aws_appconfig_application.example.id
  description    = "Example Configuration Profile"
  name           = "example-configuration-profile-tf"
  location_uri   = "hosted"

  validator {
    content = aws_lambda_function.example.arn
    type    = "LAMBDA"
  }

  tags = {
    Type = "AppConfig Configuration Profile"
  }
}
```

## Argument Reference

The following arguments are supported:

* `applicationId` - (Required, Forces new resource) Application ID. Must be between 4 and 7 characters in length.
* `locationUri` - (Required, Forces new resource) URI to locate the configuration. You can specify the AWS AppConfig hosted configuration store, Systems Manager (SSM) document, an SSM Parameter Store parameter, or an Amazon S3 object. For the hosted configuration store, specify `hosted`. For an SSM document, specify either the document name in the format `ssmDocument://<documentName>` or the ARN. For a parameter, specify either the parameter name in the format `ssmParameter://<parameterName>` or the ARN. For an Amazon S3 object, specify the URI in the following format: `s3://<bucket>/<objectKey>`.
* `name` - (Required) Name for the configuration profile. Must be between 1 and 64 characters in length.
* `description` - (Optional) Description of the configuration profile. Can be at most 1024 characters.
* `retrievalRoleArn` - (Optional) ARN of an IAM role with permission to access the configuration at the specified `locationUri`. A retrieval role ARN is not required for configurations stored in the AWS AppConfig `hosted` configuration store. It is required for all other sources that store your configuration.
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `type` - (Optional) Type of configurations contained in the profile. Valid values: `awsAppConfigFeatureFlags` and `awsFreeform`.  Default: `awsFreeform`.
* `validator` - (Optional) Set of methods for validating the configuration. Maximum of 2. See [Validator](#validator) below for more details.

### Validator

The `validator` block supports the following:

* `content` - (Optional, Required when `type` is `lambda`) Either the JSON Schema content or the ARN of an AWS Lambda function.
* `type` - (Optional) Type of validator. Valid values: `jsonSchema` and `lambda`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the AppConfig Configuration Profile.
* `configurationProfileId` - The configuration profile ID.
* `id` - AppConfig configuration profile ID and application ID separated by a colon (`:`).
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

AppConfig Configuration Profiles can be imported by using the configuration profile ID and application ID separated by a colon (`:`), e.g.,

```
$ terraform import aws_appconfig_configuration_profile.example 71abcde:11xxxxx
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-88a9e840798a4b0e4316692a5a436883a5a1535537f71c10d999e05f4408c541 -->