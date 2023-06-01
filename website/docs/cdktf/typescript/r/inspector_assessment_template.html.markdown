---
subcategory: "Inspector Classic"
layout: "aws"
page_title: "AWS: aws_inspector_assessment_template"
description: |-
  Provides an Inspector Classic Assessment Template.
---

# Resource: aws_inspector_assessment_template

Provides an Inspector Classic Assessment Template

## Example Usage

```terraform
resource "aws_inspector_assessment_template" "example" {
  name       = "example"
  target_arn = aws_inspector_assessment_target.example.arn
  duration   = 3600

  rules_package_arns = [
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-vg5GGHSD",
  ]

  event_subscription {
    event     = "ASSESSMENT_RUN_COMPLETED"
    topic_arn = aws_sns_topic.example.arn
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the assessment template.
* `targetArn` - (Required) The assessment target ARN to attach the template to.
* `duration` - (Required) The duration of the inspector run.
* `rulesPackageArns` - (Required) The rules to be used during the run.
* `eventSubscription` - (Optional) A block that enables sending notifications about a specified assessment template event to a designated SNS topic. See [Event Subscriptions](#event-subscriptions) for details.
* `tags` - (Optional) Key-value map of tags for the Inspector assessment template. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Event Subscriptions

The event subscription configuration block supports the following arguments:

* `event` - (Required) The event for which you want to receive SNS notifications. Valid values are `assessmentRunStarted`, `assessmentRunCompleted`, `assessmentRunStateChanged`, and `findingReported`.
* `topicArn` - (Required) The ARN of the SNS topic to which notifications are sent.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The template assessment ARN.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsInspectorAssessmentTemplate` can be imported by using the template assessment ARN, e.g.,

```
$ terraform import aws_inspector_assessment_template.example arn:aws:inspector:us-west-2:123456789012:target/0-9IaAzhGR/template/0-WEcjR8CH
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-74025a4d79d858a60a9bea50eab466ecb589589a4f874b52740321434b1d33c6 -->