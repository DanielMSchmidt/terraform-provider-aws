---
subcategory: "CloudHSM"
layout: "aws"
page_title: "AWS: aws_cloudhsm_v2_cluster"
description: |-
  Provides a CloudHSM v2 resource.
---

# Resource: aws_cloudhsm_v2_cluster

Creates an Amazon CloudHSM v2 cluster.

For information about CloudHSM v2, see the
[AWS CloudHSM User Guide][1] and the [Amazon
CloudHSM API Reference][2].

~> **NOTE:** A CloudHSM Cluster can take several minutes to set up.
Practically no single attribute can be updated, except for `tags`.
If you need to delete a cluster, you have to remove its HSM modules first.
To initialize cluster, you have to add an HSM instance to the cluster, then sign CSR and upload it.

## Example Usage

The following example below creates a CloudHSM cluster.

```terraform
provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "cloudhsm_v2_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-aws_cloudhsm_v2_cluster"
  }
}

resource "aws_subnet" "cloudhsm_v2_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.cloudhsm_v2_vpc.id
  cidr_block              = element(var.subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "example-aws_cloudhsm_v2_cluster"
  }
}

resource "aws_cloudhsm_v2_cluster" "cloudhsm_v2_cluster" {
  hsm_type   = "hsm1.medium"
  subnet_ids = aws_subnet.cloudhsm_v2_subnets[*].id

  tags = {
    Name = "example-aws_cloudhsm_v2_cluster"
  }
}
```

## Argument Reference

The following arguments are supported:

* `sourceBackupIdentifier` - (Optional) ID of Cloud HSM v2 cluster backup to be restored.
* `hsmType` - (Required) The type of HSM module in the cluster. Currently, only `hsm1Medium` is supported.
* `subnetIds` - (Required) The IDs of subnets in which cluster will operate.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `clusterId` - The id of the CloudHSM cluster.
* `clusterState` - The state of the CloudHSM cluster.
* `vpcId` - The id of the VPC that the CloudHSM cluster resides in.
* `securityGroupId` - The ID of the security group associated with the CloudHSM cluster.
* `clusterCertificates` - The list of cluster certificates.
    * `clusterCertificates0ClusterCertificate` - The cluster certificate issued (signed) by the issuing certificate authority (CA) of the cluster's owner.
    * `clusterCertificates0ClusterCsr` - The certificate signing request (CSR). Available only in `uninitialized` state after an HSM instance is added to the cluster.
    * `clusterCertificates0AwsHardwareCertificate` - The HSM hardware certificate issued (signed) by AWS CloudHSM.
    * `clusterCertificates0HsmCertificate` - The HSM certificate issued (signed) by the HSM hardware.
    * `clusterCertificates0ManufacturerHardwareCertificate` - The HSM hardware certificate issued (signed) by the hardware manufacturer.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

[1]: https://docs.aws.amazon.com/cloudhsm/latest/userguide/introduction.html
[2]: https://docs.aws.amazon.com/cloudhsm/latest/APIReference/Welcome.html

## Import

CloudHSM v2 Clusters can be imported using the `cluster id`, e.g.,

```
$ terraform import aws_cloudhsm_v2_cluster.test_cluster cluster-aeb282a201
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-76f0cdd829b70cdf5d671587d6d2d22ca42a4a14f169d19804bd5b9bf8563961 -->