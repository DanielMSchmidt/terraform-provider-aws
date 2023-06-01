---
subcategory: "VPC Lattice"
layout: "aws"
page_title: "AWS: aws_vpclattice_listener"
description: |-
  Terraform resource for managing an AWS VPC Lattice Listener.
---

# Resource: aws_vpclattice_listener

Terraform resource for managing an AWS VPC Lattice Listener.

## Example Usage

### Fixed response action

```
resource "aws_vpclattice_service" "test" {
  name = %[1]q
}

resource "aws_vpclattice_listener" "test" {
  name               = %[1]q
  protocol           = "HTTPS"
  service_identifier = aws_vpclattice_service.test.id
  default_action {
    fixed_response {
      status_code = 404
    }
  }
}
```

### Forward action

```
resource "aws_vpclattice_service" "test" {
  name = "example"
}

resource "aws_vpclattice_target_group" "example" {
  name = "example-target-group-1"
  type = "INSTANCE"

  config {
    port           = 80
    protocol       = "HTTP"
    vpc_identifier = aws_vpc.test.id
  }
}

resource "aws_vpclattice_listener" "example" {
  name               = "example"
  protocol           = "HTTP"
  service_identifier = aws_vpclattice_service.example.id
  default_action {
    forward {
      target_groups {
        target_group_identifier = aws_vpclattice_target_group.example.id
      }
    }
  }
}
```

### Forward action with weighted target groups

```
resource "aws_vpclattice_service" "test" {
  name = "example"
}

resource "aws_vpclattice_target_group" "example1" {
  name = "example-target-group-1"
  type = "INSTANCE"

  config {
    port           = 80
    protocol       = "HTTP"
    vpc_identifier = aws_vpc.test.id
  }
}

resource "aws_vpclattice_target_group" "example2" {
  name = "example-target-group-2"
  type = "INSTANCE"

  config {
    port           = 8080
    protocol       = "HTTP"
    vpc_identifier = aws_vpc.test.id
  }
}

resource "aws_vpclattice_listener" "example" {
  name               = "example"
  protocol           = "HTTP"
  service_identifier = aws_vpclattice_service.example.id
  default_action {
    forward {
      target_groups {
        target_group_identifier = aws_vpclattice_target_group.example1.id
        weight                  = 80
      }
      target_groups {
        target_group_identifier = aws_vpclattice_target_group.example2.id
        weight                  = 20
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `defaultAction` - (Required) Default action block for the default listener rule. Default action blocks are defined below.
* `name` - (Required, Forces new resource) Name of the listener. A listener name must be unique within a service. Valid characters are a-z, 0-9, and hyphens (-). You can't use a hyphen as the first or last character, or immediately after another hyphen.
* `port` - (Optional, Forces new resource) Listener port. You can specify a value from 1 to 65535. If `port` is not specified and `protocol` is HTTP, the value will default to 80. If `port` is not specified and `protocol` is HTTPS, the value will default to 443.
* `protocol` - (Required, Forces new resource) Protocol for the listener. Supported values are `http` or `https`
* `serviceArn` - (Optional) Amazon Resource Name (ARN) of the VPC Lattice service. You must include either the `serviceArn` or `serviceIdentifier` arguments.
* `serviceIdentifier` - (Optional) ID of the VPC Lattice service. You must include either the `serviceArn` or `serviceIdentifier` arguments.
-> **NOTE:** You must specify one of the following arguments: `serviceArn` or `serviceIdentifier`.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](/docs/providers/aws/index.html#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Default Action

Default action blocks (for `defaultAction`) must include at least one of the following argument blocks:

* `fixedResponse` - (Optional) Configuration block for returning a fixed response. See Fixed Response blocks below.
* `forward` - (Optional) Route requests to one or more target groups. See Forward blocks below.

-> **NOTE:** You must specify exactly one of the following argument blocks: `fixedResponse` or `forward`.

### Fixed Response

Fixed response blocks (for `fixedResponse`) must include the following argument:

* `statusCode` - (Required) Custom HTTP status code to return, e.g. a 404 response code. See [Listeners](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html) in the AWS documentation for a list of supported codes.

### Forward

Forward blocks (for `forward`) must include the following arguments:

* `targetGroups` - (Required) One or more target group blocks.

### Target Groups

Target group blocks (for `targetGroup`) must include the following arguments:

* `targetGroupIdentifier` - (Required) ID or Amazon Resource Name (ARN) of the target group.
* `weight` - (Optional) Determines how requests are distributed to the target group. Only required if you specify multiple target groups for a forward action. For example, if you specify two target groups, one with a
weight of 10 and the other with a weight of 20, the target group with a weight of 20 receives twice as many requests as the other target group. See [Listener rules](https://docs.aws.amazon.com/vpc-lattice/latest/ug/listeners.html#listener-rules) in the AWS documentation for additional examples. Default: `100`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the listener.
* `createdAt` - Date and time that the listener was created, specified in ISO-8601 format.
* `listenerId` - Standalone ID of the listener, e.g. `listener0A1B2C3D4E5F6G`.
* `updatedAt` - Date and time that the listener was last updated, specified in ISO-8601 format.

## Import

VPC Lattice Listener can be imported by using the `listenerId` of the listener and the `id` of the VPC Lattice service combined with a `/` character, e.g.:

```
$ terraform import aws_vpclattice_listener.example svc-1a2b3c4d/listener-987654321
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-620e1530b3f99461d571c0f5e450d079097afdf8a7078921d967d14488ec25fa -->