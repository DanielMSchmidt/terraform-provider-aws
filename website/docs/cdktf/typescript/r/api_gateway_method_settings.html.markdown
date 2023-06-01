---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_method_settings"
description: |-
  Manages API Gateway Stage Method Settings
---

# Resource: aws_api_gateway_method_settings

Manages API Gateway Stage Method Settings. For example, CloudWatch logging and metrics.

~> **NOTE:** We recommend using this resource in conjunction with the [`awsApiGatewayStage` resource](api_gateway_stage.html) instead of a stage managed by the [`awsApiGatewayDeployment` resource](api_gateway_deployment.html) optional `stageName` argument. Stages managed by the `awsApiGatewayDeployment` resource are recreated on redeployment and this resource will require a second apply to recreate the method settings.

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

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = aws_api_gateway_stage.example.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "ERROR"
  }
}

resource "aws_api_gateway_method_settings" "path_specific" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = aws_api_gateway_stage.example.stage_name
  method_path = "path1/GET"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}
```

## Argument Reference

The following arguments are supported:

* `restApiId` - (Required) ID of the REST API
* `stageName` - (Required) Name of the stage
* `methodPath` - (Required) Method path defined as `{resourcePath}/{httpMethod}` for an individual method override, or `*/*` for overriding all methods in the stage. Ensure to trim any leading forward slashes in the path (e.g., `trimprefix(aws_api_gateway_resource.example.path, "/")`).
* `settings` - (Required) Settings block, see below.

### `settings`

* `metricsEnabled` - (Optional) Whether Amazon CloudWatch metrics are enabled for this method.
* `loggingLevel` - (Optional) Logging level for this method, which effects the log entries pushed to Amazon CloudWatch Logs. The available levels are `off`, `error`, and `info`.
* `dataTraceEnabled` - (Optional) Whether data trace logging is enabled for this method, which effects the log entries pushed to Amazon CloudWatch Logs.
* `throttlingBurstLimit` - (Optional) Throttling burst limit. Default: `1` (throttling disabled).
* `throttlingRateLimit` - (Optional) Throttling rate limit. Default: `1` (throttling disabled).
* `cachingEnabled` - (Optional) Whether responses should be cached and returned for requests. A cache cluster must be enabled on the stage for responses to be cached.
* `cacheTtlInSeconds` - (Optional) Time to live (TTL), in seconds, for cached responses. The higher the TTL, the longer the response will be cached.
* `cacheDataEncrypted` - (Optional) Whether the cached responses are encrypted.
* `requireAuthorizationForCacheControl` - (Optional) Whether authorization is required for a cache invalidation request.
* `unauthorizedCacheControlHeaderStrategy` - (Optional) How to handle unauthorized requests for cache invalidation. The available values are `failWith403`, `succeedWithResponseHeader`, `succeedWithoutResponseHeader`.

## Attributes Reference

No additional attributes are exported.

## Import

`awsApiGatewayMethodSettings` can be imported using `restApiId/stageName/methodPath`, e.g.,

```
$ terraform import aws_api_gateway_method_settings.example 12345abcde/example/test/GET
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-8a3135877f295cfe02a365548d30bafb710afc7151af72e7b455a404874cdfaa -->