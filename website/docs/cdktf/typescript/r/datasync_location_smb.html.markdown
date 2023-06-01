---
subcategory: "DataSync"
layout: "aws"
page_title: "AWS: aws_datasync_location_smb"
description: |-
  Manages an AWS DataSync SMB Location
---

# Resource: aws_datasync_location_smb

Manages a SMB Location within AWS DataSync.

~> **NOTE:** The DataSync Agents must be available before creating this resource.

## Example Usage

```terraform
resource "aws_datasync_location_smb" "example" {
  server_hostname = "smb.example.com"
  subdirectory    = "/exported/path"

  user     = "Guest"
  password = "ANotGreatPassword"

  agent_arns = [aws_datasync_agent.example.arn]
}
```

## Argument Reference

The following arguments are supported:

* `agentArns` - (Required) A list of DataSync Agent ARNs with which this location will be associated.
* `domain` - (Optional) The name of the Windows domain the SMB server belongs to.
* `mountOptions` - (Optional) Configuration block containing mount options used by DataSync to access the SMB Server. Can be `automatic`, `smb2`, or `smb3`.
* `password` - (Required) The password of the user who can mount the share and has file permissions in the SMB.
* `serverHostname` - (Required) Specifies the IP address or DNS name of the SMB server. The DataSync Agent(s) use this to mount the SMB share.
* `subdirectory` - (Required) Subdirectory to perform actions as source or destination. Should be exported by the NFS server.
* `tags` - (Optional) Key-value pairs of resource tags to assign to the DataSync Location. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `user` - (Required) The user who can mount the share and has file and folder permissions in the SMB share.

### mount_options Argument Reference

The following arguments are supported inside the `mountOptions` configuration block:

* `version` - (Optional) The specific SMB version that you want DataSync to use for mounting your SMB share. Valid values: `automatic`, `smb2`, and `smb3`. Default: `automatic`

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the DataSync Location.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsDatasyncLocationSmb` can be imported by using the Amazon Resource Name (ARN), e.g.,

```
$ terraform import aws_datasync_location_smb.example arn:aws:datasync:us-east-1:123456789012:location/loc-12345678901234567
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c889911d04defd0a386bd49b92a584ef02cf04aae5133f4c9bb2d2b7cc2f6cb8 -->