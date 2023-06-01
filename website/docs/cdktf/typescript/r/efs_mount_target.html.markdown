---
subcategory: "EFS (Elastic File System)"
layout: "aws"
page_title: "AWS: aws_efs_mount_target"
description: |-
  Provides an Elastic File System (EFS) mount target.
---

# Resource: aws_efs_mount_target

Provides an Elastic File System (EFS) mount target.

## Example Usage

```terraform
resource "aws_efs_mount_target" "alpha" {
  file_system_id = aws_efs_file_system.foo.id
  subnet_id      = aws_subnet.alpha.id
}

resource "aws_vpc" "foo" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "alpha" {
  vpc_id            = aws_vpc.foo.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.1.0/24"
}
```

## Argument Reference

The following arguments are supported:

* `fileSystemId` - (Required) The ID of the file system for which the mount target is intended.
* `subnetId` - (Required) The ID of the subnet to add the mount target in.
* `ipAddress` - (Optional) The address (within the address range of the specified subnet) at
which the file system may be mounted via the mount target.
* `securityGroups` - (Optional) A list of up to 5 VPC security group IDs (that must
be for the same VPC as subnet specified) in effect for the mount target.

## Attributes Reference

~> **Note:** The `dnsName` and `mountTargetDnsName` attributes are only useful if the mount target is in a VPC that has
support for DNS hostnames enabled. See [Using DNS with Your VPC](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html)
and [VPC resource](/docs/providers/aws/r/vpc.html#enable_dns_hostnames) in Terraform for more information.

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the mount target.
* `dnsName` - The DNS name for the EFS file system.
* `mountTargetDnsName` - The DNS name for the given subnet/AZ per [documented convention](http://docs.aws.amazon.com/efs/latest/ug/mounting-fs-mount-cmd-dns-name.html).
* `fileSystemArn` - Amazon Resource Name of the file system.
* `networkInterfaceId` - The ID of the network interface that Amazon EFS created when it created the mount target.
* `availabilityZoneName` - The name of the Availability Zone (AZ) that the mount target resides in.
* `availabilityZoneId` - The unique and consistent identifier of the Availability Zone (AZ) that the mount target resides in.
* `ownerId` - AWS account ID that owns the resource.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `30M`)
- `delete` - (Default `10M`)

## Import

The EFS mount targets can be imported using the `id`, e.g.,

```
$ terraform import aws_efs_mount_target.alpha fsmt-52a643fb
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-1f57eaadcd6ea38aae5b56061a32548a7594567caf505965a42a00c6f07c8466 -->