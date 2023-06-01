---
subcategory: "ECS (Elastic Container)"
layout: "aws"
page_title: "AWS: aws_ecs_container_definition"
description: |-
    Provides details about a single container within an ecs task definition
---

# Data Source: aws_ecs_container_definition

The ECS container definition data source allows access to details of
a specific container within an AWS ECS service.

## Example Usage

```terraform
data "aws_ecs_container_definition" "ecs-mongo" {
  task_definition = aws_ecs_task_definition.mongo.id
  container_name  = "mongodb"
}
```

## Argument Reference

The following arguments are supported:

* `taskDefinition` - (Required) ARN of the task definition which contains the container
* `containerName` - (Required) Name of the container definition

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `image` - Docker image in use, including the digest
* `imageDigest` - Digest of the docker image in use
* `cpu` - CPU limit for this container definition
* `memory` - Memory limit for this container definition
* `memoryReservation` - Soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit
* `environment` - Environment in use
* `disableNetworking` - Indicator if networking is disabled
* `dockerLabels` - Set docker labels

<!-- cache-key: cdktf-0.17.0-pre.15 input-c5c674a3f09e85c6c497b77fe84c5a5914f670db4a9e5c28cff12de9c4480fdf -->