---
subcategory: "EventBridge"
layout: "aws"
page_title: "AWS: aws_cloudwatch_event_endpoint"
description: |-
  Provides a resource to create an EventBridge Global Endpoint.
---

# Resource: aws_cloudwatch_event_endpoint

Provides a resource to create an EventBridge Global Endpoint.

~> **Note:** EventBridge was formerly known as CloudWatch Events. The functionality is identical.

## Example Usage

```terraform
resource "aws_cloudwatch_event_endpoint" "this" {
  name     = "global-endpoint"
  role_arn = aws_iam_role.replication.arn

  event_bus {
    event_bus_arn = aws_cloudwatch_event_bus.primary.arn
  }
  event_bus {
    event_bus_arn = aws_cloudwatch_event_bus.secondary.arn
  }

  replication_config {
    state = "DISABLED"
  }

  routing_config {
    failover_config {
      primary {
        health_check = aws_route53_health_check.primary.arn
      }

      secondary {
        route = "us-east-2"
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `description` - (Optional) A description of the global endpoint.
* `eventBus` - (Required) The event buses to use. The names of the event buses must be identical in each Region. Exactly two event buses are required. Documented below.
* `name` - (Required) The name of the global endpoint.
* `replicationConfig` - (Optional) Parameters used for replication. Documented below.
* `roleArn` - (Optional) The ARN of the IAM role used for replication between event buses.
* `routingConfig` - (Required) Parameters used for routing, including the health check and secondary Region. Documented below.

`eventBus` supports the following:

* `eventBusArn` - (Required) The ARN of the event bus the endpoint is associated with.

`replicationConfig` supports the following:

* `state` - (Optional) The state of event replication. Valid values: `enabled`, `disabled`. The default state is `enabled`, which means you must supply a `roleArn`. If you don't have a `roleArn` or you don't want event replication enabled, set `state` to `disabled`.

`routingConfig` support the following:

* `failoverConfig` - (Required) Parameters used for failover. This includes what triggers failover and what happens when it's triggered. Documented below.

`failoverConfig` support the following:

* `primary` - (Required) Parameters used for the primary Region. Documented below.
* `secondary` - (Required) Parameters used for the secondary Region, the Region that events are routed to when failover is triggered or event replication is enabled. Documented below.

`primary` support the following:

* `healthCheck` - (Required) The ARN of the health check used by the endpoint to determine whether failover is triggered.

`secondary` support the following:

* `route` - (Required) The name of the secondary Region.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the endpoint that was created.
* `endpointUrl` - The URL of the endpoint that was created.

## Import

EventBridge Global Endpoints can be imported using the `name`, e.g.,

```shell
$ terraform import aws_cloudwatch_event_endpoint.imported_endpoint example-endpoint
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-8eadb516aa3a7b04ca2837549561c9cd076de27c8819ccb5019d8a5661b1f1c6 -->