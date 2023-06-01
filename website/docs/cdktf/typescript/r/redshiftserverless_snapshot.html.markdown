---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_snapshot"
description: |-
  Provides a Redshift Serverless Snapshot resource.
---

# Resource: aws_redshiftserverless_snapshot

Creates a new Amazon Redshift Serverless Snapshot.

## Example Usage

```terraform
resource "aws_redshiftserverless_snapshot" "example" {
  namespace_name = aws_redshiftserverless_workgroup.example.namespace_name
  snapshot_name  = "example"
}
```

## Argument Reference

The following arguments are supported:

* `namespaceName` - (Required) The namespace to create a snapshot for.
* `snapshotName` - (Required) The name of the snapshot.
* `retentionPeriod` - (Optional) How long to retain the created snapshot. Default value is `1`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `accountsWithProvisionedRestoreAccess` - All of the Amazon Web Services accounts that have access to restore a snapshot to a provisioned cluster.
* `accountsWithRestoreAccess` - All of the Amazon Web Services accounts that have access to restore a snapshot to a namespace.
* `adminUsername` - The username of the database within a snapshot.
* `arn` - The Amazon Resource Name (ARN) of the snapshot.
* `id` - The name of the snapshot.
* `kmsKeyId` - The unique identifier of the KMS key used to encrypt the snapshot.
* `namespaceArn` - The Amazon Resource Name (ARN) of the namespace the snapshot was created from.
* `ownerAccount` - The owner Amazon Web Services; account of the snapshot.

## Import

Redshift Serverless Snapshots can be imported using the `snapshotName`, e.g.,

```
$ terraform import aws_redshiftserverless_snapshot.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-e7e95b2d7c6667520d82f2ec457b67e2a898bc35c561eed69cd28cd674ab5fff -->