---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_flow_definition"
description: |-
  Provides a SageMaker Flow Definition resource.
---

# Resource: aws_sagemaker_flow_definition

Provides a SageMaker Flow Definition resource.

## Example Usage

### Basic Usage

```terraform
resource "aws_sagemaker_flow_definition" "example" {
  flow_definition_name = "example"
  role_arn             = aws_iam_role.example.arn

  human_loop_config {
    human_task_ui_arn                     = aws_sagemaker_human_task_ui.example.arn
    task_availability_lifetime_in_seconds = 1
    task_count                            = 1
    task_description                      = "example"
    task_title                            = "example"
    workteam_arn                          = aws_sagemaker_workteam.example.arn
  }

  output_config {
    s3_output_path = "s3://${aws_s3_bucket.example.bucket}/"
  }
}
```

### Public Workteam Usage

```terraform
resource "aws_sagemaker_flow_definition" "example" {
  flow_definition_name = "example"
  role_arn             = aws_iam_role.example.arn

  human_loop_config {
    human_task_ui_arn                     = aws_sagemaker_human_task_ui.example.arn
    task_availability_lifetime_in_seconds = 1
    task_count                            = 1
    task_description                      = "example"
    task_title                            = "example"
    workteam_arn                          = "arn:aws:sagemaker:${data.aws_region.current.name}:394669845002:workteam/public-crowd/default"

    public_workforce_task_price {
      amount_in_usd {
        cents                     = 1
        tenth_fractions_of_a_cent = 2
      }
    }
  }

  output_config {
    s3_output_path = "s3://${aws_s3_bucket.example.bucket}/"
  }
}
```

### Human Loop Activation Config Usage

```terraform
resource "aws_sagemaker_flow_definition" "example" {
  flow_definition_name = "example"
  role_arn             = aws_iam_role.example.arn

  human_loop_config {
    human_task_ui_arn                     = aws_sagemaker_human_task_ui.example.arn
    task_availability_lifetime_in_seconds = 1
    task_count                            = 1
    task_description                      = "example"
    task_title                            = "example"
    workteam_arn                          = aws_sagemaker_workteam.example.arn
  }

  human_loop_request_source {
    aws_managed_human_loop_request_source = "AWS/Textract/AnalyzeDocument/Forms/V1"
  }

  human_loop_activation_config {
    human_loop_activation_conditions_config {
      human_loop_activation_conditions = <<EOF
        {
			"Conditions": [
			  {
				"ConditionType": "Sampling",
				"ConditionParameters": {
				  "RandomSamplingPercentage": 5
				}
			  }
			]
		}
        EOF
    }
  }

  output_config {
    s3_output_path = "s3://${aws_s3_bucket.example.bucket}/"
  }
}
```

## Argument Reference

The following arguments are supported:

* `flowDefinitionName` - (Required) The name of your flow definition.
* `humanLoopConfig` - (Required)  An object containing information about the tasks the human reviewers will perform. See [Human Loop Config](#human-loop-config) details below.
* `roleArn` - (Required) The Amazon Resource Name (ARN) of the role needed to call other services on your behalf.
* `outputConfig` - (Required) An object containing information about where the human review results will be uploaded. See [Output Config](#output-config) details below.
* `humanLoopActivationConfig` - (Optional) An object containing information about the events that trigger a human workflow. See [Human Loop Activation Config](#human-loop-activation-config) details below.
* `humanLoopRequestSource` - (Optional) Container for configuring the source of human task requests. Use to specify if Amazon Rekognition or Amazon Textract is used as an integration source. See [Human Loop Request Source](#human-loop-request-source) details below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Human Loop Config

* `humanTaskUiArn` - (Required) The Amazon Resource Name (ARN) of the human task user interface.
* `publicWorkforceTaskPrice` - (Optional) Defines the amount of money paid to an Amazon Mechanical Turk worker for each task performed. See [Public Workforce Task Price](#public-workforce-task-price) details below.
* `taskAvailabilityLifetimeInSeconds` - (Required) The length of time that a task remains available for review by human workers. Valid value range between `1` and `864000`.
* `taskCount` - (Required) The number of distinct workers who will perform the same task on each object. Valid value range between `1` and `3`.
* `taskDescription` - (Required) A description for the human worker task.
* `taskKeywords` - (Optional) An array of keywords used to describe the task so that workers can discover the task.
* `taskTimeLimitInSeconds` - (Optional) The amount of time that a worker has to complete a task. The default value is `3600` seconds.
* `taskTitle` - (Required) A title for the human worker task.
* `workteamArn` - (Required) The Amazon Resource Name (ARN) of the human task user interface. Amazon Resource Name (ARN) of a team of workers. For Public workforces see [AWS Docs](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-management-public.html).

#### Public Workforce Task Price

* `amountInUsd` - (Optional) Defines the amount of money paid to an Amazon Mechanical Turk worker in United States dollars. See [Amount In Usd](#amount-in-usd) details below.

##### Amount In Usd

* `cents` - (Optional) The fractional portion, in cents, of the amount. Valid value range between `0` and `99`.
* `dollars` - (Optional) The whole number of dollars in the amount. Valid value range between `0` and `2`.
* `tenthFractionsOfACent` - (Optional) Fractions of a cent, in tenths. Valid value range between `0` and `9`.

### Human Loop Activation Config

* `humanLoopActivationConditionsConfig` - (Required) defines under what conditions SageMaker creates a human loop. See [Human Loop Activation Conditions Config](#human-loop-activation-conditions-config) details below.

#### Human Loop Activation Conditions Config

* `humanLoopActivationConditions` - (Required) A JSON expressing use-case specific conditions declaratively. If any condition is matched, atomic tasks are created against the configured work team. For more information about how to structure the JSON, see [JSON Schema for Human Loop Activation Conditions in Amazon Augmented AI](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-human-fallback-conditions-json-schema.html).

### Human Loop Request Source

* `awsManagedHumanLoopRequestSource` - (Required) Specifies whether Amazon Rekognition or Amazon Textract are used as the integration source. Valid values are: `aws/rekognition/detectModerationLabels/image/v3` and `aws/textract/analyzeDocument/forms/v1`.

### Output Config

* `s3OutputPath` - (Required) The Amazon S3 path where the object containing human output will be made available.
* `kmsKeyId` - (Optional) The Amazon Key Management Service (KMS) key ARN for server-side encryption.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Flow Definition.
* `id` - The name of the Flow Definition.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

SageMaker Flow Definitions can be imported using the `flowDefinitionName`, e.g.,

```
$ terraform import aws_sagemaker_flow_definition.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b500ce5485d1d32b34607a75fc1b8ab1fd626ea1e9bed35ec6b47f2dcc5708a0 -->