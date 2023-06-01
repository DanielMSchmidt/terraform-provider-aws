---
subcategory: "CloudWatch Observability Access Manager"
layout: "aws"
page_title: "AWS: aws_oam_link"
description: |-
  Terraform resource for managing an AWS CloudWatch Observability Access Manager Link.
---

# Resource: aws_oam_link

Terraform resource for managing an AWS CloudWatch Observability Access Manager Link.

## Example Usage

### Basic Usage

```terraform
resource "aws_oam_link" "example" {
  label_template  = "$AccountName"
  resource_types  = ["AWS::CloudWatch::Metric"]
  sink_identifier = aws_oam_sink.test.id
  tags = {
    Env = "prod"
  }
}
```

## Argument Reference

The following arguments are required:

* `labelTemplate` - (Required) Human-readable name to use to identify this source account when you are viewing data from it in the monitoring account.
* `resourceTypes` - (Required) Types of data that the source account shares with the monitoring account.
* `sinkIdentifier` - (Required) Identifier of the sink to use to create this link.

The following arguments are optional:

* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the link.
* `label` - Label that is assigned to this link.
* `linkId` - ID string that AWS generated as part of the link ARN.
* `sinkArn` - ARN of the sink that is used for this link.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `1M`)
* `update` - (Default `1M`)
* `delete` - (Default `1M`)

## Import

CloudWatch Observability Access Manager Link can be imported using the `arn`, e.g.,

```
$ terraform import aws_oam_link.example arn:aws:oam:us-west-2:123456789012:link/link-id
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-fd0be61cce3fb1bea76a809bd5937c6759759fa3fc4f1cad4d081fa8a968807e -->