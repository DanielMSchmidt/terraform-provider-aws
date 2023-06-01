---
subcategory: "AppStream 2.0"
layout: "aws"
page_title: "AWS: aws_appstream_image_builder"
description: |-
  Provides an AppStream image builder
---

# Resource: aws_appstream_image_builder

Provides an AppStream image builder.

## Example Usage

```terraform
resource "aws_appstream_image_builder" "test_fleet" {
  name                           = "Name"
  description                    = "Description of a ImageBuilder"
  display_name                   = "Display name of a ImageBuilder"
  enable_default_internet_access = false
  image_name                     = "AppStream-WinServer2019-10-05-2022"
  instance_type                  = "stream.standard.large"

  vpc_config {
    subnet_ids = [aws_subnet.example.id]
  }

  tags = {
    Name = "Example Image Builder"
  }
}
```

## Argument Reference

The following arguments are required:

* `instanceType` - (Required) Instance type to use when launching the image builder.
* `name` - (Required) Unique name for the image builder.

The following arguments are optional:

* `accessEndpoint` - (Optional) Set of interface VPC endpoint (interface endpoint) objects. Maximum of 4. See below.
* `appstreamAgentVersion` - (Optional) Version of the AppStream 2.0 agent to use for this image builder.
* `description` - (Optional) Description to display.
* `displayName` - (Optional) Human-readable friendly name for the AppStream image builder.
* `domainJoinInfo` - (Optional) Configuration block for the name of the directory and organizational unit (OU) to use to join the image builder to a Microsoft Active Directory domain. See below.
* `enableDefaultInternetAccess` - (Optional) Enables or disables default internet access for the image builder.
* `iamRoleArn` - (Optional) ARN of the IAM role to apply to the image builder.
* `imageArn` - (Optional, Required if `imageName` not provided) ARN of the public, private, or shared image to use.
* `imageName` - (Optional, Required if `imageArn` not provided) Name of the image used to create the image builder.
* `vpcConfig` - (Optional) Configuration block for the VPC configuration for the image builder. See below.
* `tags` - (Optional) Map of tags to assign to the instance. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### `accessEndpoint`

The `accessEndpoint` block supports the following arguments:

* `endpointType` - (Required) Type of interface endpoint.
* `vpceId` - (Optional) Identifier (ID) of the VPC in which the interface endpoint is used.

### `domainJoinInfo`

The `domainJoinInfo` block supports the following arguments:

* `directoryName` - (Optional) Fully qualified name of the directory (for example, corp.example.com).
* `organizationalUnitDistinguishedName` - (Optional) Distinguished name of the organizational unit for computer accounts.

### `vpcConfig`

The `vpcConfig` block supports the following arguments:

* `securityGroupIds` - (Optional) Identifiers of the security groups for the image builder or image builder.
* `subnetIds` - (Optional) Identifiers of the subnets to which a network interface is attached from the image builder instance or image builder instance.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the appstream image builder.
* `createdTime` -  Date and time, in UTC and extended RFC 3339 format, when the image builder was created.
* `id` - Name of the image builder.
* `state` - State of the image builder. Can be: `pending`, `updatingAgent`, `running`, `stopping`, `stopped`, `rebooting`, `snapshotting`, `deleting`, `failed`, `updating`, `pendingQualification`
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsAppstreamImageBuilder` can be imported using the `name`, e.g.,

```
$ terraform import aws_appstream_image_builder.example imageBuilderExample
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-d757a28c60efd6e3b360d39da95724f5f219d13fb47d83cabf5d832a2fe0ff81 -->