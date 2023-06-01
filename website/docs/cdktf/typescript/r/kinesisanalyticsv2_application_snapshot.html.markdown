---
subcategory: "Kinesis Analytics V2"
layout: "aws"
page_title: "AWS: aws_kinesisanalyticsv2_application_snapshot"
description: |-
  Manages a Kinesis Analytics v2 Application Snapshot.
---

# Resource: aws_kinesisanalyticsv2_application_snapshot

Manages a Kinesis Analytics v2 Application Snapshot.
Snapshots are the AWS implementation of [Flink Savepoints](https://ci.apache.org/projects/flink/flink-docs-release-1.11/ops/state/savepoints.html).

## Example Usage

```terraform
resource "aws_kinesisanalyticsv2_application_snapshot" "example" {
  application_name = aws_kinesisanalyticsv2_application.example.name
  snapshot_name    = "example-snapshot"
}
```

## Argument Reference

The following arguments are supported:

* `applicationName` - (Required) The name of an existing  [Kinesis Analytics v2 Application](/docs/providers/aws/r/kinesisanalyticsv2_application.html). Note that the application must be running for a snapshot to be created.
* `snapshotName` - (Required) The name of the application snapshot.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The application snapshot identifier.
* `applicationVersionId` - The current application version ID when the snapshot was created.
* `snapshotCreationTimestamp` - The timestamp of the application snapshot.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `10M`)
- `delete` - (Default `10M`)

## Import

`awsKinesisanalyticsv2Application` can be imported by using `applicationName` together with `snapshotName`, e.g.,

```
$ terraform import aws_kinesisanalyticsv2_application_snapshot.example example-application/example-snapshot
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-d253d49850d8d875bede79b53efac361cecac5d1e90a2b016b79f64447be5309 -->