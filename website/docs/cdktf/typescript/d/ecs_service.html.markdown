---
subcategory: "ECS (Elastic Container)"
layout: "aws"
page_title: "AWS: aws_ecs_service"
description: |-
    Provides details about an ecs service
---

# Data Source: aws_ecs_service

The ECS Service data source allows access to details of a specific
Service within a AWS ECS Cluster.

## Example Usage

```terraform
data "aws_ecs_service" "example" {
  service_name = "example"
  cluster_arn  = data.aws_ecs_cluster.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `serviceName` - (Required) Name of the ECS Service
* `clusterArn` - (Required) ARN of the ECS Cluster

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the ECS Service
* `desiredCount` - Number of tasks for the ECS Service
* `launchType` - Launch type for the ECS Service
* `schedulingStrategy` - Scheduling strategy for the ECS Service
* `taskDefinition` - Family for the latest ACTIVE revision or full ARN of the task definition.
* `tags` - Resource tags.

<!-- cache-key: cdktf-0.17.0-pre.15 input-b714a5a13dc0e58f9d257f4c27a1140f90d05d483f85fc5e4a28394cee742698 -->