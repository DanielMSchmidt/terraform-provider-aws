---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_stage"
description: |-
  Manages an API Gateway Stage.
---

# Resource: aws_api_gateway_stage

Manages an API Gateway Stage. A stage is a named reference to a deployment, which can be done via the [`awsApiGatewayDeployment` resource](api_gateway_deployment.html). Stages can be optionally managed further with the [`awsApiGatewayBasePathMapping` resource](api_gateway_base_path_mapping.html), [`awsApiGatewayDomainName` resource](api_gateway_domain_name.html), and [`awsApiMethodSettings` resource](api_gateway_method_settings.html). For more information, see the [API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-stages.html).

## Example Usage

An end-to-end example of a REST API configured with OpenAPI can be found in the [`/examples/apiGatewayRestApiOpenapi` directory within the GitHub repository](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples/api-gateway-rest-api-openapi).

```terraform
resource "aws_api_gateway_rest_api" "example" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "example"
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "example"
}

resource "aws_api_gateway_method_settings" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = aws_api_gateway_stage.example.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}
```

### Managing the API Logging CloudWatch Log Group

API Gateway provides the ability to [enable CloudWatch API logging](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html). To manage the CloudWatch Log Group when this feature is enabled, the [`awsCloudwatchLogGroup` resource](/docs/providers/aws/r/cloudwatch_log_group.html) can be used where the name matches the API Gateway naming convention. If the CloudWatch Log Group previously exists, the [`awsCloudwatchLogGroup` resource can be imported into Terraform](/docs/providers/aws/r/cloudwatch_log_group.html#import) as a one time operation and recreation of the environment can occur without import.

-> The below configuration uses [`dependsOn`](https://www.terraform.io/language/meta-arguments/depends_on) to prevent ordering issues with API Gateway automatically creating the log group first and a variable for naming consistency. Other ordering and naming methodologies may be more appropriate for your environment.

```terraform
variable "stage_name" {
  default = "example"
  type    = string
}

resource "aws_api_gateway_rest_api" "example" {
  # ... other configuration ...
}

resource "aws_api_gateway_stage" "example" {
  depends_on = [aws_cloudwatch_log_group.example]

  stage_name = var.stage_name
  # ... other configuration ...
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.example.id}/${var.stage_name}"
  retention_in_days = 7
  # ... potentially other configuration ...
}
```

## Argument Reference

The following arguments are supported:

* `restApiId` - (Required) ID of the associated REST API
* `stageName` - (Required) Name of the stage
* `deploymentId` - (Required) ID of the deployment that the stage points to
* `accessLogSettings` - (Optional) Enables access logs for the API stage. See [Access Log Settings](#access-log-settings) below.
* `cacheClusterEnabled` - (Optional) Whether a cache cluster is enabled for the stage
* `cacheClusterSize` - (Optional) Size of the cache cluster for the stage, if enabled. Allowed values include `05`, `16`, `61`, `135`, `284`, `582`, `118` and `237`.
* `canarySettings` - (Optional) Configuration settings of a canary deployment. See [Canary Settings](#canary-settings) below.
* `clientCertificateId` - (Optional) Identifier of a client certificate for the stage.
* `description` - (Optional) Description of the stage.
* `documentationVersion` - (Optional) Version of the associated API documentation
* `variables` - (Optional) Map that defines the stage variables
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `xrayTracingEnabled` - (Optional) Whether active tracing with X-ray is enabled. Defaults to `false`.

### Access Log Settings

* `destinationArn` - (Required) ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. If you specify a Kinesis Data Firehose delivery stream, the stream name must begin with `amazonApigateway`. Automatically removes trailing `:*` if present.
* `format` - (Required) Formatting and values recorded in the logs.
For more information on configuring the log format rules visit the AWS [documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html)

### Canary Settings

* `percentTraffic` - (Optional) Percent `00` - `1000` of traffic to divert to the canary deployment.
* `stageVariableOverrides` - (Optional) Map of overridden stage `variables` (including new variables) for the canary deployment.
* `useStageCache` - (Optional) Whether the canary deployment uses the stage cache. Defaults to false.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN
* `id` - ID of the stage
* `invokeUrl` - URL to invoke the API pointing to the stage,
  e.g., `https://z4675Bid1JExecuteApiEuWest2AmazonawsCom/prod`
* `executionArn` - Execution ARN to be used in [`lambdaPermission`](/docs/providers/aws/r/lambda_permission.html)'s `sourceArn`
  when allowing API Gateway to invoke a Lambda function,
  e.g., `arn:aws:executeApi:euWest2:123456789012:z4675Bid1J/prod`
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `webAclArn` - ARN of the WebAcl associated with the Stage.

## Import

`awsApiGatewayStage` can be imported using `restApiId/stageName`, e.g.,

```
$ terraform import aws_api_gateway_stage.example 12345abcde/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-e3051769440b1a979381c524971445fb9499a0d23eb454498fdefeb9e6b86576 -->