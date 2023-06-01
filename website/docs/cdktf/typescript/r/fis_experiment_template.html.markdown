---
subcategory: "FIS (Fault Injection Simulator)"
layout: "aws"
page_title: "AWS: aws_fis_experiment_template"
description: |-
  Provides an FIS Experiment Template.
---

# Resource: aws_fis_experiment_template

Provides an FIS Experiment Template, which can be used to run an experiment.
An experiment template contains one or more actions to run on specified targets during an experiment.
It also contains the stop conditions that prevent the experiment from going out of bounds.
See [Amazon Fault Injection Simulator](https://docs.aws.amazon.com/fis/index.html)
for more information.

## Example Usage

```terraform
resource "aws_fis_experiment_template" "example" {
  description = "example"
  role_arn    = aws_iam_role.example.arn

  stop_condition {
    source = "none"
  }

  action {
    name      = "example-action"
    action_id = "aws:ec2:terminate-instances"

    target {
      key   = "Instances"
      value = "example-target"
    }
  }

  target {
    name           = "example-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "COUNT(1)"

    resource_tag {
      key   = "env"
      value = "example"
    }
  }
}
```

## Argument Reference

The following arguments are required:

* `action` - (Required) Action to be performed during an experiment. See below.
* `description` - (Required) Description for the experiment template.
* `roleArn` - (Required) ARN of an IAM role that grants the AWS FIS service permission to perform service actions on your behalf.
* `stopCondition` - (Required) When an ongoing experiment should be stopped. See below.

The following arguments are optional:

* `tags` - (Optional) Key-value mapping of tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `target` - (Optional) Target of an action. See below.

### `action`

* `actionId` - (Required) ID of the action. To find out what actions are supported see [AWS FIS actions reference](https://docs.aws.amazon.com/fis/latest/userguide/fis-actions-reference.html).
* `name` - (Required) Friendly name of the action.
* `description` - (Optional) Description of the action.
* `parameter` - (Optional) Parameter(s) for the action, if applicable. See below.
* `startAfter` - (Optional) Set of action names that must complete before this action can be executed.
* `target` - (Optional) Action's target, if applicable. See below.

#### `parameter`

* `key` - (Required) Parameter name.
* `value` - (Required) Parameter value.

For a list of parameters supported by each action, see [AWS FIS actions reference](https://docs.aws.amazon.com/fis/latest/userguide/fis-actions-reference.html).

#### `target` (`action.*Target`)

* `key` - (Required) Target type. Valid values are `cluster` (EKS Cluster), `clusters` (ECS Clusters), `dbInstances` (RDS DB Instances), `instances` (EC2 Instances), `nodegroups` (EKS Node groups), `roles` (IAM Roles), `spotInstances` (EC2 Spot Instances), `subnets` (VPC Subnets).
* `value` - (Required) Target name, referencing a corresponding target.

### `stopCondition`

* `source` - (Required) Source of the condition. One of `none`, `aws:cloudwatch:alarm`.
* `value` - (Optional) ARN of the CloudWatch alarm. Required if the source is a CloudWatch alarm.

### `target`

* `name` - (Required) Friendly name given to the target.
* `resourceType` - (Required) AWS resource type. The resource type must be supported for the specified action. To find out what resource types are supported, see [Targets for AWS FIS](https://docs.aws.amazon.com/fis/latest/userguide/targets.html#resource-types).
* `selectionMode` - (Required) Scopes the identified resources. Valid values are `all` (all identified resources), `count(n)` (randomly select `n` of the identified resources), `percent(n)` (randomly select `n` percent of the identified resources).
* `filter` - (Optional) Filter(s) for the target. Filters can be used to select resources based on specific attributes returned by the respective describe action of the resource type. For more information, see [Targets for AWS FIS](https://docs.aws.amazon.com/fis/latest/userguide/targets.html#target-filters). See below.
* `resourceArns` - (Optional) Set of ARNs of the resources to target with an action. Conflicts with `resourceTag`.
* `resourceTag` - (Optional) Tag(s) the resources need to have to be considered a valid target for an action. Conflicts with `resourceArns`. See below.

~> **NOTE:** The `target` configuration block requires either `resourceArns` or `resourceTag`.

#### `filter`

* `path` - (Required) Attribute path for the filter.
* `values` - (Required) Set of attribute values for the filter.

~> **NOTE:** Values specified in a `filter` are joined with an `or` clause, while values across multiple `filter` blocks are joined with an `and` clause. For more information, see [Targets for AWS FIS](https://docs.aws.amazon.com/fis/latest/userguide/targets.html#target-filters).

#### `resourceTag`

* `key` - (Required) Tag key.
* `value` - (Required) Tag value.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Experiment Template ID.

## Import

FIS Experiment Templates can be imported using the `id`, e.g.

```
$ terraform import aws_fis_experiment_template.template EXT123AbCdEfGhIjK
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-63240d8479f1f174f31720f6ee66809f45a9d6e2bc4152ea4621d25657ea6ddb -->