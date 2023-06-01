---
subcategory: "Neptune"
layout: "aws"
page_title: "AWS: aws_neptune_cluster_snapshot"
description: |-
  Manages a Neptune database cluster snapshot.
---

# Resource: aws_neptune_cluster_snapshot

Manages a Neptune database cluster snapshot.

## Example Usage

```terraform
resource "aws_neptune_cluster_snapshot" "example" {
  db_cluster_identifier          = aws_neptune_cluster.example.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1234"
}
```

## Argument Reference

The following arguments are supported:

* `dbClusterIdentifier` - (Required) The DB Cluster Identifier from which to take the snapshot.
* `dbClusterSnapshotIdentifier` - (Required) The Identifier for the snapshot.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `allocatedStorage` - Specifies the allocated storage size in gigabytes (GB).
* `availabilityZones` - List of EC2 Availability Zones that instances in the DB cluster snapshot can be restored in.
* `dbClusterSnapshotArn` - The Amazon Resource Name (ARN) for the DB Cluster Snapshot.
* `engine` - Specifies the name of the database engine.
* `engineVersion` - Version of the database engine for this DB cluster snapshot.
* `kmsKeyId` - If storage_encrypted is true, the AWS KMS key identifier for the encrypted DB cluster snapshot.
* `licenseModel` - License model information for the restored DB cluster.
* `port` - Port that the DB cluster was listening on at the time of the snapshot.
* `sourceDbClusterSnapshotIdentifier` - The DB Cluster Snapshot Arn that the DB Cluster Snapshot was copied from. It only has value in case of cross customer or cross region copy.
* `storageEncrypted` - Specifies whether the DB cluster snapshot is encrypted.
* `status` - The status of this DB Cluster Snapshot.
* `vpcId` - The VPC ID associated with the DB cluster snapshot.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `20M`)

## Import

`awsNeptuneClusterSnapshot` can be imported by using the cluster snapshot identifier, e.g.,

```
$ terraform import aws_neptune_cluster_snapshot.example my-cluster-snapshot
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-40903b8138b1b4454de1a1c6d2870378547565b6084a2ead504e22ca384c5215 -->