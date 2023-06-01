---
subcategory: "DataSync"
layout: "aws"
page_title: "AWS: aws_datasync_location_efs"
description: |-
  Manages an EFS Location within AWS DataSync.
---

# Resource: aws_datasync_location_efs

Manages an AWS DataSync EFS Location.

~> **NOTE:** The EFS File System must have a mounted EFS Mount Target before creating this resource.

## Example Usage

```terraform
resource "aws_datasync_location_efs" "example" {
  # The below example uses aws_efs_mount_target as a reference to ensure a mount target already exists when resource creation occurs.
  # You can accomplish the same behavior with depends_on or an aws_efs_mount_target data source reference.
  efs_file_system_arn = aws_efs_mount_target.example.file_system_arn

  ec2_config {
    security_group_arns = [aws_security_group.example.arn]
    subnet_arn          = aws_subnet.example.arn
  }
}
```

## Argument Reference

The following arguments are supported:

* `accessPointArn` - (Optional) Specifies the Amazon Resource Name (ARN) of the access point that DataSync uses to access the Amazon EFS file system.
* `ec2Config` - (Required) Configuration block containing EC2 configurations for connecting to the EFS File System.
* `efsFileSystemArn` - (Required) Amazon Resource Name (ARN) of EFS File System.
* `fileSystemAccessRoleArn` - (Optional)  Specifies an Identity and Access Management (IAM) role that DataSync assumes when mounting the Amazon EFS file system.
* `inTransitEncryption` - (Optional) Specifies whether you want DataSync to use TLS encryption when transferring data to or from your Amazon EFS file system. Valid values are `none` and `tls12`.
* `subdirectory` - (Optional) Subdirectory to perform actions as source or destination. Default `/`.
* `tags` - (Optional) Key-value pairs of resource tags to assign to the DataSync Location. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### ec2_config Argument Reference

The following arguments are supported inside the `ec2Config` configuration block:

* `securityGroupArns` - (Required) List of Amazon Resource Names (ARNs) of the EC2 Security Groups that are associated with the EFS Mount Target.
* `subnetArn` - (Required) Amazon Resource Name (ARN) of the EC2 Subnet that is associated with the EFS Mount Target.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the DataSync Location.
* `arn` - Amazon Resource Name (ARN) of the DataSync Location.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsDatasyncLocationEfs` can be imported by using the DataSync Task Amazon Resource Name (ARN), e.g.,

```
$ terraform import aws_datasync_location_efs.example arn:aws:datasync:us-east-1:123456789012:location/loc-12345678901234567
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-dae4cbb3923f9655f523d9d3613518dfa6c491bcdeab157ea100b93ebf3596a5 -->