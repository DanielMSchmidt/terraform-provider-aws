---
subcategory: "AppConfig"
layout: "aws"
page_title: "AWS: aws_appconfig_configuration_profiles"
description: |-
    Terraform data source for managing an AWS AppConfig Configuration Profiles.
---

# Data Source: aws_appconfig_configuration_profiles

Provides access to all Configuration Properties for an AppConfig Application. This will allow you to pass Configuration
Profile IDs to another resource.

## Example Usage

### Basic Usage

```terraform
data "aws_appconfig_configuration_profiles" "example" {
  application_id = "a1d3rpe"
}

data "aws_appconfig_configuration_profile" "example" {
  for_each                 = data.aws_appconfig_configuration_profiles.example.configuration_profile_ids
  configuration_profile_id = each.value
  application_id           = aws_appconfig_application.example.id
}
```

## Argument Reference

The following arguments are required:

* `applicationId` - (Required) ID of the AppConfig Application.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `configurationProfileIds` - Set of Configuration Profile IDs associated with the AppConfig Application.

<!-- cache-key: cdktf-0.17.0-pre.15 input-b7d99f2641da4c2f4a2099eacae858e35b9f90d2aaf8e544182d87a42ff14840 -->