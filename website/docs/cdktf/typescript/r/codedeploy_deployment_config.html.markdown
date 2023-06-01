---
subcategory: "CodeDeploy"
layout: "aws"
page_title: "AWS: aws_codedeploy_deployment_config"
description: |-
  Provides a CodeDeploy deployment config.
---

# Resource: aws_codedeploy_deployment_config

Provides a CodeDeploy deployment config for an application

## Example Usage

### Server Usage

```terraform
resource "aws_codedeploy_deployment_config" "foo" {
  deployment_config_name = "test-deployment-config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 2
  }
}

resource "aws_codedeploy_deployment_group" "foo" {
  app_name               = aws_codedeploy_app.foo_app.name
  deployment_group_name  = "bar"
  service_role_arn       = aws_iam_role.foo_role.arn
  deployment_config_name = aws_codedeploy_deployment_config.foo.id

  ec2_tag_filter {
    key   = "filterkey"
    type  = "KEY_AND_VALUE"
    value = "filtervalue"
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "foo-trigger"
    trigger_target_arn = "foo-topic-arn"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}
```

### Lambda Usage

```terraform
resource "aws_codedeploy_deployment_config" "foo" {
  deployment_config_name = "test-deployment-config"
  compute_platform       = "Lambda"

  traffic_routing_config {
    type = "TimeBasedLinear"

    time_based_linear {
      interval   = 10
      percentage = 10
    }
  }
}

resource "aws_codedeploy_deployment_group" "foo" {
  app_name               = aws_codedeploy_app.foo_app.name
  deployment_group_name  = "bar"
  service_role_arn       = aws_iam_role.foo_role.arn
  deployment_config_name = aws_codedeploy_deployment_config.foo.id

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_STOP_ON_ALARM"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}
```

## Argument Reference

The following arguments are supported:

* `deploymentConfigName` - (Required) The name of the deployment config.
* `computePlatform` - (Optional) The compute platform can be `server`, `lambda`, or `ecs`. Default is `server`.
* `minimumHealthyHosts` - (Optional) A minimum_healthy_hosts block. Required for `server` compute platform. Minimum Healthy Hosts are documented below.
* `trafficRoutingConfig` - (Optional) A traffic_routing_config block. Traffic Routing Config is documented below.

The `minimumHealthyHosts` block supports the following:

* `type` - (Required) The type can either be `fleetPercent` or `hostCount`.
* `value` - (Required) The value when the type is `fleetPercent` represents the minimum number of healthy instances as
a percentage of the total number of instances in the deployment. If you specify FLEET_PERCENT, at the start of the
deployment, AWS CodeDeploy converts the percentage to the equivalent number of instance and rounds up fractional instances.
When the type is `hostCount`, the value represents the minimum number of healthy instances as an absolute value.

The `trafficRoutingConfig` block supports the following:

* `type` - (Optional) Type of traffic routing config. One of `timeBasedCanary`, `timeBasedLinear`, `allAtOnce`.
* `timeBasedCanary` - (Optional) The time based canary configuration information. If `type` is `timeBasedLinear`, use `timeBasedLinear` instead.
* `timeBasedLinear` - (Optional) The time based linear configuration information. If `type` is `timeBasedCanary`, use `timeBasedCanary` instead.

The `timeBasedCanary` block supports the following:

* `interval` - (Optional) The number of minutes between the first and second traffic shifts of a `timeBasedCanary` deployment.
* `percentage` - (Optional) The percentage of traffic to shift in the first increment of a `timeBasedCanary` deployment.

The `timeBasedLinear` block supports the following:

* `interval` - (Optional) The number of minutes between each incremental traffic shift of a `timeBasedLinear` deployment.
* `percentage` - (Optional) The percentage of traffic that is shifted at the start of each increment of a `timeBasedLinear` deployment.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The deployment group's config name.
* `deploymentConfigId` - The AWS Assigned deployment config id

## Import

CodeDeploy Deployment Configurations can be imported using the `deploymentConfigName`, e.g.,

```
$ terraform import aws_codedeploy_deployment_config.example my-deployment-config
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b4f07cf3735458d4e3c2f5eb84f79f160b6f0b461445f95bf3e81d0b68ab9eec -->