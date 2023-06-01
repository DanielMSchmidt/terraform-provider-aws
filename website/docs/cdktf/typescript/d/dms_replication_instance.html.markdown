---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_certificate"
description: |-
  Terraform data source for managing an AWS DMS (Database Migration) Replication Instance.
---

# Data Source: aws_dms_replication_instance

Terraform data source for managing an AWS DMS (Database Migration) Replication Instance.

## Example Usage

```terraform
data "aws_dms_replication_instance" "test" {
  replication_instance_id = aws_dms_replication_instance.test.replication_instance_id
}
```

## Argument Reference

The following arguments are required:

* `replicationInstanceId` - (Required) The replication instance identifier. This parameter is stored as a lowercase string.

    - Must contain from 1 to 63 alphanumeric characters or hyphens.
    - First character must be a letter.
    - Cannot end with a hyphen
    - Cannot contain two consecutive hyphens.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `allocatedStorage` - (Default: 50, Min: 5, Max: 6144) The amount of storage (in gigabytes) to be initially allocated for the replication instance.
* `allowMajorVersionUpgrade` - (Default: false) Indicates that major version upgrades are allowed.
* `applyImmediately` - (Default: false) Indicates whether the changes should be applied immediately or during the next maintenance window. Only used when updating an existing resource.
* `autoMinorVersionUpgrade` - (Default: false) Indicates that minor engine upgrades will be applied automatically to the replication instance during the maintenance window.
* `availabilityZone` - The EC2 Availability Zone that the replication instance will be created in.
* `engineVersion` - The engine version number of the replication instance.
* `kmsKeyArn` - The Amazon Resource Name (ARN) for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for `kmsKeyArn`, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region.
* `multiAz` - Specifies if the replication instance is a multi-az deployment. You cannot set the `availabilityZone` parameter if the `multiAz` parameter is set to `true`.
* `preferredMaintenanceWindow` - The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).

    - Default: A 30-minute window selected at random from an 8-hour block of time per region, occurring on a random day of the week.
    - Format: `ddd:hh24:miDdd:hh24:mi`
    - Valid Days: `mon, tue, wed, thu, fri, sat, sun`
    - Constraints: Minimum 30-minute window.

* `publiclyAccessible` - (Default: false) Specifies the accessibility options for the replication instance. A value of true represents an instance with a public IP address. A value of false represents an instance with a private IP address.
* `replicationInstanceArn` - The Amazon Resource Name (ARN) of the replication instance.
* `replicationInstanceClass` - The compute and memory capacity of the replication instance as specified by the replication instance class. See [AWS DMS User Guide](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.Types.html) for available instance sizes and advice on which one to choose.
* `replicationInstancePrivateIps` - A list of the private IP addresses of the replication instance.
* `replicationInstancePublicIps` - A list of the public IP addresses of the replication instance.
* `replicationSubnetGroupId` - (Optional) A subnet group to associate with the replication instance.
* `vpcSecurityGroupIds` - (Optional) A list of VPC security group IDs to be used with the replication instance. The VPC security groups must work with the VPC containing the replication instance.

<!-- cache-key: cdktf-0.17.0-pre.15 input-7b0102ea11e920dd0ccd240f0b086393bb9c23f222ade2848beaaf1bc3831d55 -->