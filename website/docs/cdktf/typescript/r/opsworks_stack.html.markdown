---
subcategory: "OpsWorks"
layout: "aws"
page_title: "AWS: aws_opsworks_stack"
description: |-
  Provides an OpsWorks stack resource.
---

# Resource: aws_opsworks_stack

Provides an OpsWorks stack resource.

## Example Usage

```terraform
resource "aws_opsworks_stack" "main" {
  name                         = "awesome-stack"
  region                       = "us-west-1"
  service_role_arn             = aws_iam_role.opsworks.arn
  default_instance_profile_arn = aws_iam_instance_profile.opsworks.arn

  tags = {
    Name = "foobar-terraform-stack"
  }

  custom_json = <<EOT
{
 "foobar": {
    "version": "1.0.0"
  }
}
EOT
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the stack.
* `region` - (Required) The name of the region where the stack will exist.
* `serviceRoleArn` - (Required) The ARN of an IAM role that the OpsWorks service will act as.
* `defaultInstanceProfileArn` - (Required) The ARN of an IAM Instance Profile that created instances will have by default.
* `agentVersion` - (Optional) If set to `"latest"`, OpsWorks will automatically install the latest version.
* `berkshelfVersion` - (Optional) If `manageBerkshelf` is enabled, the version of Berkshelf to use.
* `color` - (Optional) Color to paint next to the stack's resources in the OpsWorks console.
* `configurationManagerName` - (Optional) Name of the configuration manager to use. Defaults to "Chef".
* `configurationManagerVersion` - (Optional) Version of the configuration manager to use. Defaults to "11.4".
* `customCookbooksSource` - (Optional) When `useCustomCookbooks` is set, provide this sub-object as described below.
* `customJson` - (Optional) User defined JSON passed to "Chef". Use a "here doc" for multiline JSON.
* `defaultAvailabilityZone` - (Optional) Name of the availability zone where instances will be created by default.
  Cannot be set when `vpcId` is set.
* `defaultOs` - (Optional) Name of OS that will be installed on instances by default.
* `defaultRootDeviceType` - (Optional) Name of the type of root device instances will have by default.
* `defaultSshKeyName` - (Optional) Name of the SSH keypair that instances will have by default.
* `defaultSubnetId` - (Optional) ID of the subnet in which instances will be created by default.
  Required if `vpcId` is set to a VPC other than the default VPC, and forbidden if it isn't.
* `hostnameTheme` - (Optional) Keyword representing the naming scheme that will be used for instance hostnames within this stack.
* `manageBerkshelf` - (Optional) Boolean value controlling whether Opsworks will run Berkshelf for this stack.
* `tags` - (Optional) A map of tags to assign to the resource.
  If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `useCustomCookbooks` - (Optional) Boolean value controlling whether the custom cookbook settings are enabled.
* `useOpsworksSecurityGroups` - (Optional) Boolean value controlling whether the standard OpsWorks security groups apply to created instances.
* `vpcId` - (Optional) ID of the VPC that this stack belongs to.
  Defaults to the region's default VPC.
* `customJson` - (Optional) Custom JSON attributes to apply to the entire stack.

The `customCookbooksSource` block supports the following arguments:

* `type` - (Required) The type of source to use. For example, "archive".
* `url` - (Required) The URL where the cookbooks resource can be found.
* `username` - (Optional) Username to use when authenticating to the source.
* `password` - (Optional) Password to use when authenticating to the source. Terraform cannot perform drift detection of this configuration.
* `sshKey` - (Optional) SSH key to use when authenticating to the source. Terraform cannot perform drift detection of this configuration.
* `revision` - (Optional) For sources that are version-aware, the revision to use.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The id of the stack.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

OpsWorks stacks can be imported using the `id`, e.g.,

```
$ terraform import aws_opsworks_stack.bar 00000000-0000-0000-0000-000000000000
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f1446dd0c1132d529f5fdbab26fb7f11b1f0cfa975da30dacba42fe846bb38d6 -->