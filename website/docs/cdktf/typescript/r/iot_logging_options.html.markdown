---
subcategory: "IoT Core"
layout: "aws"
page_title: "AWS: aws_iot_logging_options"
description: |-
    Provides a resource to manage default logging options.
---

# Resource: aws_iot_logging_options

Provides a resource to manage [default logging options](https://docs.aws.amazon.com/iot/latest/developerguide/configure-logging.html#configure-logging-console).

## Example Usage

```terraform
resource "aws_iot_logging_options" "example" {
  default_log_level = "WARN"
  role_arn          = aws_iam_role.example.arn
}
```

## Argument Reference

* `defaultLogLevel` - (Optional) The default logging level. Valid Values: `"debug"`, `"info"`, `"error"`, `"warn"`, `"disabled"`.
* `disableAllLogs` - (Optional) If `true` all logs are disabled. The default is `false`.
* `roleArn` - (Required) The ARN of the role that allows IoT to write to Cloudwatch logs.

## Attributes Reference

No additional attributes are exported.

<!-- cache-key: cdktf-0.17.0-pre.15 input-df29cd61d00b402fdf9858640e2516af65ec030e0fe41744b0e76b18254cbf4d -->