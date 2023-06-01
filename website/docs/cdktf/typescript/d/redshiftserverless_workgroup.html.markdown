---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_workgroup"
description: |-
  Terraform data source for managing an AWS Redshift Serverless Workgroup.
---

# Data Source: aws_redshiftserverless_workgroup

Terraform data source for managing an AWS Redshift Serverless Workgroup.

## Example Usage

### Basic Usage

```terraform
data "aws_redshiftserverless_workgroup" "example" {
  workgroup_name = aws_redshiftserverless_workgroup.example.workgroup_name
}
```

## Argument Reference

The following arguments are required:

* `workgroupName` - (Required) The name of the workgroup associated with the database.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Redshift Serverless Workgroup.
* `id` - The Redshift Workgroup Name.
* `endpoint` - The endpoint that is created from the workgroup. See `endpoint` below.
* `enhancedVpcRouting` - The value that specifies whether to turn on enhanced virtual private cloud (VPC) routing, which forces Amazon Redshift Serverless to route traffic through your VPC instead of over the internet.
* `publiclyAccessible` - A value that specifies whether the workgroup can be accessed from a public network.
* `securityGroupIds` - An array of security group IDs to associate with the workgroup.
* `subnetIds` - An array of VPC subnet IDs to associate with the workgroup. When set, must contain at least three subnets spanning three Availability Zones. A minimum number of IP addresses is required and scales with the Base Capacity. For more information, see the following [AWS document](https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-known-issues.html).
* `workgroupId` - The Redshift Workgroup ID.

### Endpoint

* `address` - The DNS address of the VPC endpoint.
* `port` - The port that Amazon Redshift Serverless listens on.
* `vpcEndpoint` - The VPC endpoint or the Redshift Serverless workgroup. See `VPC Endpoint` below.

#### VPC Endpoint

* `vpcEndpointId` - The DNS address of the VPC endpoint.
* `vpcId` - The port that Amazon Redshift Serverless listens on.
* `networkInterface` - The network interfaces of the endpoint.. See `Network Interface` below.

##### Network Interface

* `availabilityZone` - The availability Zone.
* `networkInterfaceId` - The unique identifier of the network interface.
* `privateIpAddress` - The IPv4 address of the network interface within the subnet.
* `subnetId` - The unique identifier of the subnet.

<!-- cache-key: cdktf-0.17.0-pre.15 input-14a078201be5e07a60a01f0cbc0f841faaa4d4b680b133f1a3bc063f85c21aaf -->