---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_cluster_snapshot"
description: |-
  Creates a Redshift cluster snapshot
---

# Resource: aws_redshift_cluster_snapshot

Creates a Redshift cluster snapshot

## Example Usage

```terraform
resource "aws_redshift_cluster_snapshot" "example" {
  cluster_snapshot_name = "example"
  cluster_snapshot_content = jsonencode(
    {
      AllowDBUserOverride = "1"
      Client_ID           = "ExampleClientID"
      App_ID              = "example"
    }
  )
}
```

## Argument Reference

The following arguments are supported:

* `clusterIdentifier` - (Required, Forces new resource) The cluster identifier for which you want a snapshot.
* `snapshotIdentifier` - (Required, Forces new resource) A unique identifier for the snapshot that you are requesting. This identifier must be unique for all snapshots within the Amazon Web Services account.
* `manualSnapshotRetentionPeriod` - (Optional) The number of days that a manual snapshot is retained. If the value is `1`, the manual snapshot is retained indefinitely. Valid values are -1 and between `1` and `3653`.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the snapshot.
* `id` - A unique identifier for the snapshot that you are requesting. This identifiermust be unique for all snapshots within the Amazon Web Services account.
* `kmsKeyId` - The Key Management Service (KMS) key ID of the encryption key that was used to encrypt data in the cluster from which the snapshot was taken.
* `ownerAccount` - For manual snapshots, the Amazon Web Services account used to create or copy the snapshot. For automatic snapshots, the owner of the cluster. The owner can perform all snapshot actions, such as sharing a manual snapshot.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Redshift Cluster Snapshots support import by `snapshotIdentifier`, e.g.,

```console
$ terraform import aws_redshift_cluster_snapshot.test example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-dff93e31aab74fb4b00096afe24ea9bc056957a6b8806cc3b088717537b51797 -->