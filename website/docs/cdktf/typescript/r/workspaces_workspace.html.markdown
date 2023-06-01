---
subcategory: "WorkSpaces"
layout: "aws"
page_title: "AWS: aws_workspaces_workspace"
description: |-
  Provides a workspaces in AWS Workspaces Service.
---

# Resource: aws_workspaces_workspace

Provides a workspace in [AWS Workspaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces.html) Service

~> **NOTE:** AWS WorkSpaces service requires [`workspacesDefaultRole`](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-access-control.html#create-default-role) IAM role to operate normally.

## Example Usage

```terraform
data "aws_workspaces_bundle" "value_windows_10" {
  bundle_id = "wsb-bh8rsxt14" # Value with Windows 10 (English)
}

resource "aws_workspaces_workspace" "example" {
  directory_id = aws_workspaces_directory.example.id
  bundle_id    = data.aws_workspaces_bundle.value_windows_10.id
  user_name    = "john.doe"

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = "alias/aws/workspaces"

  workspace_properties {
    compute_type_name                         = "VALUE"
    user_volume_size_gib                      = 10
    root_volume_size_gib                      = 80
    running_mode                              = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }

  tags = {
    Department = "IT"
  }
}
```

## Argument Reference

The following arguments are supported:

* `directoryId` - (Required) The ID of the directory for the WorkSpace.
* `bundleId` - (Required) The ID of the bundle for the WorkSpace.
* `userName` – (Required) The user name of the user for the WorkSpace. This user name must exist in the directory for the WorkSpace.
* `rootVolumeEncryptionEnabled` - (Optional) Indicates whether the data stored on the root volume is encrypted.
* `userVolumeEncryptionEnabled` – (Optional) Indicates whether the data stored on the user volume is encrypted.
* `volumeEncryptionKey` – (Optional) The symmetric AWS KMS customer master key (CMK) used to encrypt data stored on your WorkSpace. Amazon WorkSpaces does not support asymmetric CMKs.
* `tags` - (Optional) The tags for the WorkSpace. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `workspaceProperties` – (Optional) The WorkSpace properties.

`workspaceProperties` supports the following:

* `computeTypeName` – (Optional) The compute type. For more information, see [Amazon WorkSpaces Bundles](http://aws.amazon.com/workspaces/details/#Amazon_WorkSpaces_Bundles). Valid values are `value`, `standard`, `performance`, `power`, `graphics`, `powerpro`, `graphicspro`, `graphicsG4Dn`, and `graphicsproG4Dn`.
* `rootVolumeSizeGib` – (Optional) The size of the root volume.
* `runningMode` – (Optional) The running mode. For more information, see [Manage the WorkSpace Running Mode](https://docs.aws.amazon.com/workspaces/latest/adminguide/running-mode.html). Valid values are `autoStop` and `alwaysOn`.
* `runningModeAutoStopTimeoutInMinutes` – (Optional) The time after a user logs off when WorkSpaces are automatically stopped. Configured in 60-minute intervals.
* `userVolumeSizeGib` – (Optional) The size of the user storage.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The workspaces ID.
* `ipAddress` - The IP address of the WorkSpace.
* `computerName` - The name of the WorkSpace, as seen by the operating system.
* `state` - The operational state of the WorkSpace.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `30M`)
- `update` - (Default `10M`)
- `delete` - (Default `10M`)

## Import

Workspaces can be imported using their ID, e.g.,

```
$ terraform import aws_workspaces_workspace.example ws-9z9zmbkhv
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-6561d0d58a2ad5a427728d422ac82eefac669c59f7766ee3509c87a7a64d2115 -->