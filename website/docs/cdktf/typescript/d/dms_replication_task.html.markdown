---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_replication_task"
description: |-
  Terraform data source for managing an AWS DMS (Database Migration) Replication Task.
---

# Data Source: aws_dms_replication_task

Terraform data source for managing an AWS DMS (Database Migration) Replication Task.

## Example Usage

### Basic Usage

```terraform
data "aws_dms_replication_task" "test" {
  replication_task_id = aws_dms_replication_task.test.replication_task_id
}
```

## Argument Reference

The following arguments are required:

* `replicationTaskId` - (Required) The replication task identifier.

    - Must contain from 1 to 255 alphanumeric characters or hyphens.
    - First character must be a letter.
    - Cannot end with a hyphen.
    - Cannot contain two consecutive hyphens.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `cdcStartPosition` - (Conflicts with `cdcStartTime`) Indicates when you want a change data capture (CDC) operation to start. The value can be in date, checkpoint, or LSN/SCN format depending on the source engine. For more information, see [Determining a CDC native start point](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Task.CDC.html#CHAP_Task.CDC.StartPoint.Native).
* `cdcStartTime` - (Conflicts with `cdcStartPosition`) The Unix timestamp integer for the start of the Change Data Capture (CDC) operation.
* `migrationType` - The migration type. Can be one of `full-load | cdc | full-load-and-cdc`.
* `replicationInstanceArn` - The Amazon Resource Name (ARN) of the replication instance.
* `replicationTaskSettings` - An escaped JSON string that contains the task settings. For a complete list of task settings, see [Task Settings for AWS Database Migration Service Tasks](http://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TaskSettings.html).
* `sourceEndpointArn` - The Amazon Resource Name (ARN) string that uniquely identifies the source endpoint.
* `startReplicationTask` -  Whether to run or stop the replication task.
* `status` - Replication Task status.
* `tableMappings` - An escaped JSON string that contains the table mappings. For information on table mapping see [Using Table Mapping with an AWS Database Migration Service Task to Select and Filter Data](http://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.html)
* `targetEndpointArn` - The Amazon Resource Name (ARN) string that uniquely identifies the target endpoint.
* `replicationTaskArn` - The Amazon Resource Name (ARN) for the replication task.

<!-- cache-key: cdktf-0.17.0-pre.15 input-67a6070920919f8cd3896223c71aeb7313d63973eb296505415c85b93ff70310 -->