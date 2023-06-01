---
subcategory: "ECS (Elastic Container)"
layout: "aws"
page_title: "AWS: aws_ecs_capacity_provider"
description: |-
  Provides an ECS cluster capacity provider.
---

# Resource: aws_ecs_capacity_provider

Provides an ECS cluster capacity provider. More information can be found on the [ECS Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-capacity-providers.html).

~> **NOTE:** Associating an ECS Capacity Provider to an Auto Scaling Group will automatically add the `amazonEcsManaged` tag to the Auto Scaling Group. This tag should be included in the `awsAutoscalingGroup` resource configuration to prevent Terraform from removing it in subsequent executions as well as ensuring the `amazonEcsManaged` tag is propagated to all EC2 Instances in the Auto Scaling Group if `minSize` is above 0 on creation. Any EC2 Instances in the Auto Scaling Group without this tag must be manually be updated, otherwise they may cause unexpected scaling behavior and metrics.

## Example Usage

```terraform
resource "aws_autoscaling_group" "test" {
  # ... other configuration, including potentially other tags ...

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "test" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.test.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `autoScalingGroupProvider` - (Required) Configuration block for the provider for the ECS auto scaling group. Detailed below.
* `name` - (Required) Name of the capacity provider.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### `autoScalingGroupProvider`

* `autoScalingGroupArn` - (Required) - ARN of the associated auto scaling group.
* `managedScaling` - (Optional) - Configuration block defining the parameters of the auto scaling. Detailed below.
* `managedTerminationProtection` - (Optional) - Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. Valid values are `enabled` and `disabled`.

### `managedScaling`

* `instanceWarmupPeriod` - (Optional) Period of time, in seconds, after a newly launched Amazon EC2 instance can contribute to CloudWatch metrics for Auto Scaling group. If this parameter is omitted, the default value of 300 seconds is used.
* `maximumScalingStepSize` - (Optional) Maximum step adjustment size. A number between 1 and 10,000.
* `minimumScalingStepSize` - (Optional) Minimum step adjustment size. A number between 1 and 10,000.
* `status` - (Optional) Whether auto scaling is managed by ECS. Valid values are `enabled` and `disabled`.
* `targetCapacity` - (Optional) Target utilization for the capacity provider. A number between 1 and 100.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN that identifies the capacity provider.
* `id` - ARN that identifies the capacity provider.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

ECS Capacity Providers can be imported using the `name`, e.g.,

```
$ terraform import aws_ecs_capacity_provider.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-069c65b8b8f54556800555f266343758f2428f9d18cb56e6c17dece61d274a9e -->