---
subcategory: "AppConfig"
layout: "aws"
page_title: "AWS: aws_appconfig_environment"
description: |-
  Provides an AppConfig Environment resource.
---

# Resource: aws_appconfig_environment

Provides an AppConfig Environment resource for an [`awsAppconfigApplication` resource](appconfig_application.html.markdown). One or more environments can be defined for an application.

## Example Usage

```terraform
resource "aws_appconfig_environment" "example" {
  name           = "example-environment-tf"
  description    = "Example AppConfig Environment"
  application_id = aws_appconfig_application.example.id

  monitor {
    alarm_arn      = aws_cloudwatch_metric_alarm.example.arn
    alarm_role_arn = aws_iam_role.example.arn
  }

  tags = {
    Type = "AppConfig Environment"
  }
}

resource "aws_appconfig_application" "example" {
  name        = "example-application-tf"
  description = "Example AppConfig Application"

  tags = {
    Type = "AppConfig Application"
  }
}
```

## Argument Reference

The following arguments are supported:

* `applicationId` - (Required, Forces new resource) AppConfig application ID. Must be between 4 and 7 characters in length.
* `name` - (Required) Name for the environment. Must be between 1 and 64 characters in length.
* `description` - (Optional) Description of the environment. Can be at most 1024 characters.
* `monitor` - (Optional) Set of Amazon CloudWatch alarms to monitor during the deployment process. Maximum of 5. See [Monitor](#monitor) below for more details.
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Monitor

The `monitor` block supports the following:

* `alarmArn` - (Required) ARN of the Amazon CloudWatch alarm.
* `alarmRoleArn` - (Optional) ARN of an IAM role for AWS AppConfig to monitor `alarmArn`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the AppConfig Environment.
* `id` - AppConfig environment ID and application ID separated by a colon (`:`).
* `environmentId` - AppConfig environment ID.
* `state` - State of the environment. Possible values are `readyForDeployment`, `deploying`, `rollingBack`
  or `rolledBack`.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

AppConfig Environments can be imported by using the environment ID and application ID separated by a colon (`:`), e.g.,

```
$ terraform import aws_appconfig_environment.example 71abcde:11xxxxx
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f72b678acceb004522bf815d88eb2b3949d5e5a74c547ea49a4d49ea05c44635 -->