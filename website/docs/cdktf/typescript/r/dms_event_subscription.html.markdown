---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_event_subscription"
description: |-
  Provides a DMS (Data Migration Service) event subscription resource.
---

# Resource: aws_dms_event_subscription

Provides a DMS (Data Migration Service) event subscription resource.

## Example Usage

```terraform
resource "aws_dms_event_subscription" "example" {
  enabled          = true
  event_categories = ["creation", "failure"]
  name             = "my-favorite-event-subscription"
  sns_topic_arn    = aws_sns_topic.example.arn
  source_ids       = [aws_dms_replication_task.example.replication_task_id]
  source_type      = "replication-task"

  tags = {
    Name = "example"
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of event subscription.
* `enabled` - (Optional, Default: true) Whether the event subscription should be enabled.
* `eventCategories` - (Optional) List of event categories to listen for, see `describeEventCategories` for a canonical list.
* `sourceType` - (Optional, Default: all events) Type of source for events. Valid values: `replicationInstance` or `replicationTask`
* `sourceIds` - (Required) Ids of sources to listen to.
* `snsTopicArn` - (Required) SNS topic arn to send events on.
* `tags` - (Optional) Map of resource tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the DMS Event Subscription.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `10M`)
- `update` - (Default `10M`)
- `delete` - (Default `10M`)

## Import

Event subscriptions can be imported using the `name`, e.g.,

```
$ terraform import aws_dms_event_subscription.test my-awesome-event-subscription
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-2c89158e993f0861a38377f1f1ca13ba032e5f081ac04ade3fb3e377a917793b -->