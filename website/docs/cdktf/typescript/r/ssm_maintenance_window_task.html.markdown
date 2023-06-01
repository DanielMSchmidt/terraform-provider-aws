---
subcategory: "SSM (Systems Manager)"
layout: "aws"
page_title: "AWS: aws_ssm_maintenance_window_task"
description: |-
  Provides an SSM Maintenance Window Task resource
---

# Resource: aws_ssm_maintenance_window_task

Provides an SSM Maintenance Window Task resource

## Example Usage

### Automation Tasks

```terraform
resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency = 2
  max_errors      = 1
  priority        = 1
  task_arn        = "AWS-RestartEC2Instance"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.example.id

  targets {
    key    = "InstanceIds"
    values = [aws_instance.example.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = [aws_instance.example.id]
      }
    }
  }
}
```

### Lambda Tasks

```terraform
resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency = 2
  max_errors      = 1
  priority        = 1
  task_arn        = aws_lambda_function.example.arn
  task_type       = "LAMBDA"
  window_id       = aws_ssm_maintenance_window.example.id

  targets {
    key    = "InstanceIds"
    values = [aws_instance.example.id]
  }

  task_invocation_parameters {
    lambda_parameters {
      client_context = base64encode("{\"key1\":\"value1\"}")
      payload        = "{\"key1\":\"value1\"}"
    }
  }
}
```

### Run Command Tasks

```terraform
resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency = 2
  max_errors      = 1
  priority        = 1
  task_arn        = "AWS-RunShellScript"
  task_type       = "RUN_COMMAND"
  window_id       = aws_ssm_maintenance_window.example.id

  targets {
    key    = "InstanceIds"
    values = [aws_instance.example.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = aws_s3_bucket.example.id
      output_s3_key_prefix = "output"
      service_role_arn     = aws_iam_role.example.arn
      timeout_seconds      = 600

      notification_config {
        notification_arn    = aws_sns_topic.example.arn
        notification_events = ["All"]
        notification_type   = "Command"
      }

      parameter {
        name   = "commands"
        values = ["date"]
      }
    }
  }
}
```

### Step Function Tasks

```terraform
resource "aws_ssm_maintenance_window_task" "example" {
  max_concurrency = 2
  max_errors      = 1
  priority        = 1
  task_arn        = aws_sfn_activity.example.id
  task_type       = "STEP_FUNCTIONS"
  window_id       = aws_ssm_maintenance_window.example.id

  targets {
    key    = "InstanceIds"
    values = [aws_instance.example.id]
  }

  task_invocation_parameters {
    step_functions_parameters {
      input = "{\"key1\":\"value1\"}"
      name  = "example"
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `windowId` - (Required) The Id of the maintenance window to register the task with.
* `maxConcurrency` - (Optional) The maximum number of targets this task can be run for in parallel.
* `maxErrors` - (Optional) The maximum number of errors allowed before this task stops being scheduled.
* `cutoffBehavior` - (Optional) Indicates whether tasks should continue to run after the cutoff time specified in the maintenance windows is reached. Valid values are `continueTask` and `cancelTask`.
* `taskType` - (Required) The type of task being registered. Valid values: `automation`, `lambda`, `runCommand` or `stepFunctions`.
* `taskArn` - (Required) The ARN of the task to execute.
* `serviceRoleArn` - (Optional) The role that should be assumed when executing the task. If a role is not provided, Systems Manager uses your account's service-linked role. If no service-linked role for Systems Manager exists in your account, it is created for you.
* `name` - (Optional) The name of the maintenance window task.
* `description` - (Optional) The description of the maintenance window task.
* `targets` - (Optional) The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2.
* `priority` - (Optional) The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel.
* `taskInvocationParameters` - (Optional) Configuration block with parameters for task execution.

`taskInvocationParameters` supports the following:

* `automationParameters` - (Optional) The parameters for an AUTOMATION task type. Documented below.
* `lambdaParameters` - (Optional) The parameters for a LAMBDA task type. Documented below.
* `runCommandParameters` - (Optional) The parameters for a RUN_COMMAND task type. Documented below.
* `stepFunctionsParameters` - (Optional) The parameters for a STEP_FUNCTIONS task type. Documented below.

`automationParameters` supports the following:

* `documentVersion` - (Optional) The version of an Automation document to use during task execution.
* `parameter` - (Optional) The parameters for the RUN_COMMAND task execution. Documented below.

`lambdaParameters` supports the following:

* `clientContext` - (Optional) Pass client-specific information to the Lambda function that you are invoking.
* `payload` - (Optional) JSON to provide to your Lambda function as input.
* `qualifier` - (Optional) Specify a Lambda function version or alias name.

`runCommandParameters` supports the following:

* `comment` - (Optional) Information about the command(s) to execute.
* `documentHash` - (Optional) The SHA-256 or SHA-1 hash created by the system when the document was created. SHA-1 hashes have been deprecated.
* `documentHashType` - (Optional) SHA-256 or SHA-1. SHA-1 hashes have been deprecated. Valid values: `sha256` and `sha1`
* `notificationConfig` - (Optional) Configurations for sending notifications about command status changes on a per-instance basis. Documented below.
* `outputS3Bucket` - (Optional) The name of the Amazon S3 bucket.
* `outputS3KeyPrefix` - (Optional) The Amazon S3 bucket subfolder.
* `parameter` - (Optional) The parameters for the RUN_COMMAND task execution. Documented below.
* `serviceRoleArn` - (Optional) The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.
* `timeoutSeconds` - (Optional) If this time is reached and the command has not already started executing, it doesn't run.
* `cloudwatchConfig` - (Optional) Configuration options for sending command output to CloudWatch Logs. Documented below.

`stepFunctionsParameters` supports the following:

* `input` - (Optional) The inputs for the STEP_FUNCTION task.
* `name` - (Optional) The name of the STEP_FUNCTION task.

`notificationConfig` supports the following:

* `notificationArn` - (Optional) An Amazon Resource Name (ARN) for a Simple Notification Service (SNS) topic. Run Command pushes notifications about command status changes to this topic.
* `notificationEvents` - (Optional) The different events for which you can receive notifications. Valid values: `all`, `inProgress`, `success`, `timedOut`, `cancelled`, and `failed`
* `notificationType` - (Optional) When specified with `command`, receive notification when the status of a command changes. When specified with `invocation`, for commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. Valid values: `command` and `invocation`

`cloudwatchConfig` supports the following:

* `cloudwatchLogGroupName` - (Optional) The name of the CloudWatch log group where you want to send command output. If you don't specify a group name, Systems Manager automatically creates a log group for you. The log group uses the following naming format: aws/ssm/SystemsManagerDocumentName.
* `cloudwatchOutputEnabled` - (Optional) Enables Systems Manager to send command output to CloudWatch Logs.

`parameter` supports the following:

* `name` - (Required) The parameter name.
* `values` - (Required) The array of strings.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the maintenance window task.
* `id` - The ID of the maintenance window task.
* `windowTaskId` - The ID of the maintenance window task.

## Import

AWS Maintenance Window Task can be imported using the `windowId` and `windowTaskId` separated by `/`.

```sh
$ terraform import aws_ssm_maintenance_window_task.task <window_id>/<window_task_id>
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-de7797bd2dea89a0f43bffcca848eabb7061f8325966d917db2c4ead56331b12 -->