---
subcategory: "EC2 Image Builder"
layout: "aws"
page_title: "AWS: aws_imagebuilder_image_pipeline"
description: |-
    Manages an Image Builder Image Pipeline
---

# Resource: aws_imagebuilder_image_pipeline

Manages an Image Builder Image Pipeline.

## Example Usage

```terraform
resource "aws_imagebuilder_image_pipeline" "example" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.example.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.example.arn
  name                             = "example"

  schedule {
    schedule_expression = "cron(0 0 * * ? *)"
  }
}
```

## Argument Reference

The following arguments are required:

* `infrastructureConfigurationArn` - (Required) Amazon Resource Name (ARN) of the Image Builder Infrastructure Configuration.
* `name` - (Required) Name of the image pipeline.

The following arguments are optional:

* `containerRecipeArn` - (Optional) Amazon Resource Name (ARN) of the container recipe.
* `description` - (Optional) Description of the image pipeline.
* `distributionConfigurationArn` - (Optional) Amazon Resource Name (ARN) of the Image Builder Distribution Configuration.
* `enhancedImageMetadataEnabled` - (Optional) Whether additional information about the image being created is collected. Defaults to `true`.
* `imageRecipeArn` - (Optional) Amazon Resource Name (ARN) of the image recipe.
* `imageTestsConfiguration` - (Optional) Configuration block with image tests configuration. Detailed below.
* `schedule` - (Optional) Configuration block with schedule settings. Detailed below.
* `status` - (Optional) Status of the image pipeline. Valid values are `disabled` and `enabled`. Defaults to `enabled`.
* `tags` - (Optional) Key-value map of resource tags for the image pipeline. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### image_tests_configuration

The following arguments are optional:

* `imageTestsEnabled` - (Optional) Whether image tests are enabled. Defaults to `true`.
* `timeoutMinutes` - (Optional) Number of minutes before image tests time out. Valid values are between `60` and `1440`. Defaults to `720`.

### schedule

The following arguments are required:

* `scheduleExpression` - (Required) Cron expression of how often the pipeline start condition is evaluated. For example, `cron(0 0 * * ? *)` is evaluated every day at midnight UTC. Configurations using the five field syntax that was previously accepted by the API, such as `cron(0 0 * * *)`, must be updated to the six field syntax. For more information, see the [Image Builder User Guide](https://docs.aws.amazon.com/imagebuilder/latest/userguide/cron-expressions.html).

The following arguments are optional:

* `pipelineExecutionStartCondition` - (Optional) Condition when the pipeline should trigger a new image build. Valid values are `expressionMatchAndDependencyUpdatesAvailable` and `expressionMatchOnly`. Defaults to `expressionMatchAndDependencyUpdatesAvailable`.

* `timezone` - (Optional) The timezone that applies to the scheduling expression. For example, "Etc/UTC", "America/Los_Angeles" in the [IANA timezone format](https://www.joda.org/joda-time/timezones.html). If not specified this defaults to UTC.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the image pipeline.
* `dateCreated` - Date the image pipeline was created.
* `dateLastRun` - Date the image pipeline was last run.
* `dateNextRun` - Date the image pipeline will run next.
* `dateUpdated` - Date the image pipeline was updated.
* `platform` - Platform of the image pipeline.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsImagebuilderImagePipeline` resources can be imported using the Amazon Resource Name (ARN), e.g.,

```
$ terraform import aws_imagebuilder_image_pipeline.example arn:aws:imagebuilder:us-east-1:123456789012:image-pipeline/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-9a365121ce9b3eee71303b694fba4e8a6b77cc222fdee8d2553480e3be5d3def -->