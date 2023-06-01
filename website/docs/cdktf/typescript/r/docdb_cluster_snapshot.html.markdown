---
subcategory: "DocumentDB"
layout: "aws"
page_title: "AWS: aws_docdb_cluster_snapshot"
description: |-
  Manages a DocumentDB database cluster snapshot.
---

# Resource: aws_docdb_cluster_snapshot

Manages a DocumentDB database cluster snapshot for DocumentDB clusters.

## Example Usage

```terraform
resource "aws_docdb_cluster_snapshot" "example" {
  db_cluster_identifier          = aws_docdb_cluster.example.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1234"
}
```

## Argument Reference

The following arguments are supported:

* `dbClusterIdentifier` - (Required) The DocumentDB Cluster Identifier from which to take the snapshot.
* `dbClusterSnapshotIdentifier` - (Required) The Identifier for the snapshot.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `availabilityZones` - List of EC2 Availability Zones that instances in the DocumentDB cluster snapshot can be restored in.
* `dbClusterSnapshotArn` - The Amazon Resource Name (ARN) for the DocumentDB Cluster Snapshot.
* `engine` - Specifies the name of the database engine.
* `engineVersion` - Version of the database engine for this DocumentDB cluster snapshot.
* `kmsKeyId` - If storage_encrypted is true, the AWS KMS key identifier for the encrypted DocumentDB cluster snapshot.
* `port` - Port that the DocumentDB cluster was listening on at the time of the snapshot.
* `sourceDbClusterSnapshotIdentifier` - The DocumentDB Cluster Snapshot Arn that the DocumentDB Cluster Snapshot was copied from. It only has value in case of cross customer or cross region copy.
* `storageEncrypted` - Specifies whether the DocumentDB cluster snapshot is encrypted.
* `status` - The status of this DocumentDB Cluster Snapshot.
* `vpcId` - The VPC ID associated with the DocumentDB cluster snapshot.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `20M`)

## Import

`awsDocdbClusterSnapshot` can be imported by using the cluster snapshot identifier, e.g.,

```
$ terraform import aws_docdb_cluster_snapshot.example my-cluster-snapshot
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-a1bbb9c52fc5818cc56447b9e46b4c34af365548929991142c10e1bd9f8afcc8 -->