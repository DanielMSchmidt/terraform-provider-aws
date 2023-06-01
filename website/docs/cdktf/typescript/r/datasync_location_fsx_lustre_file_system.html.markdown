---
subcategory: "DataSync"
layout: "aws"
page_title: "AWS: aws_datasync_location_fsx_lustre_file_system"
description: |-
  Manages an FSx Lustre Location within AWS DataSync.
---

# Resource: aws_datasync_location_fsx_lustre_file_system

Manages an AWS DataSync FSx Lustre Location.

## Example Usage

```terraform
resource "aws_datasync_location_fsx_lustre_file_system" "example" {
  fsx_filesystem_arn  = aws_fsx_lustre_file_system.example.arn
  security_group_arns = [aws_security_group.example.arn]
}
```

## Argument Reference

The following arguments are supported:

* `fsxFilesystemArn` - (Required) The Amazon Resource Name (ARN) for the FSx for Lustre file system.
* `securityGroupArns` - (Optional) The Amazon Resource Names (ARNs) of the security groups that are to use to configure the FSx for Lustre file system.
* `subdirectory` - (Optional) Subdirectory to perform actions as source or destination.
* `tags` - (Optional) Key-value pairs of resource tags to assign to the DataSync Location. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the DataSync Location.
* `arn` - Amazon Resource Name (ARN) of the DataSync Location.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uri` - The URL of the FSx for Lustre location that was described.
* `creationTime` - The time that the FSx for Lustre location was created.

## Import

`awsDatasyncLocationFsxLustreFileSystem` can be imported by using the `dataSyncArn#fSxLustreArn`, e.g.,

```
$ terraform import aws_datasync_location_fsx_lustre_file_system.example arn:aws:datasync:us-west-2:123456789012:location/loc-12345678901234567#arn:aws:fsx:us-west-2:476956259333:file-system/fs-08e04cd442c1bb94a
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c9e094d9a49a864754c2d361fde4db60dfb83ebccf1c95d798bb93e687ef5721 -->