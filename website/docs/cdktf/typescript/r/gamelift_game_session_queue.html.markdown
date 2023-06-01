---
subcategory: "GameLift"
layout: "aws"
page_title: "AWS: aws_gamelift_game_session_queue"
description: |-
  Provides a GameLift Game Session Queue resource.
---

# Resource: aws_gamelift_game_session_queue

Provides an GameLift Game Session Queue resource.

## Example Usage

```terraform
resource "aws_gamelift_game_session_queue" "test" {
  name = "example-session-queue"

  destinations = [
    aws_gamelift_fleet.us_west_2_fleet.arn,
    aws_gamelift_fleet.eu_central_1_fleet.arn,
  ]

  notification_target = aws_sns_topic.game_session_queue_notifications.arn

  player_latency_policy {
    maximum_individual_player_latency_milliseconds = 100
    policy_duration_seconds                        = 5
  }

  player_latency_policy {
    maximum_individual_player_latency_milliseconds = 200
  }

  timeout_in_seconds = 60
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the session queue.
* `timeoutInSeconds` - (Required) Maximum time a game session request can remain in the queue.
* `customEventData` - (Optional) Information to be added to all events that are related to this game session queue.
* `destinations` - (Optional) List of fleet/alias ARNs used by session queue for placing game sessions.
* `notificationTarget` - (Optional) An SNS topic ARN that is set up to receive game session placement notifications.
* `playerLatencyPolicy` - (Optional) One or more policies used to choose fleet based on player latency. See below.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Nested Fields

#### `playerLatencyPolicy`

* `maximumIndividualPlayerLatencyMilliseconds` - (Required) Maximum latency value that is allowed for any player.
* `policyDurationSeconds` - (Optional) Length of time that the policy is enforced while placing a new game session. Absence of value for this attribute means that the policy is enforced until the queue times out.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Game Session Queue ARN.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

GameLift Game Session Queues can be imported by their `name`, e.g.,

```
$ terraform import aws_gamelift_game_session_queue.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-5001d711c1c3a354189ec4b92056f1ccdfb696ece8f5fc82b9c24c0eff61b4e7 -->