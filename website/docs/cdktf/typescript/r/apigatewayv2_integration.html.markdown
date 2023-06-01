---
subcategory: "API Gateway V2"
layout: "aws"
page_title: "AWS: aws_apigatewayv2_integration"
description: |-
  Manages an Amazon API Gateway Version 2 integration.
---

# Resource: aws_apigatewayv2_integration

Manages an Amazon API Gateway Version 2 integration.
More information can be found in the [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html).

## Example Usage

### Basic

```terraform
resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.example.id
  integration_type = "MOCK"
}
```

### Lambda Integration

```terraform
resource "aws_lambda_function" "example" {
  filename      = "example.zip"
  function_name = "Example"
  role          = aws_iam_role.example.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.example.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.example.invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}
```

### AWS Service Integration

```terraform
resource "aws_apigatewayv2_integration" "example" {
  api_id              = aws_apigatewayv2_api.example.id
  credentials_arn     = aws_iam_role.example.arn
  description         = "SQS example"
  integration_type    = "AWS_PROXY"
  integration_subtype = "SQS-SendMessage"

  request_parameters = {
    "QueueUrl"    = "$request.header.queueUrl"
    "MessageBody" = "$request.body.message"
  }
}
```

### Private Integration

```terraform
resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.example.id
  credentials_arn  = aws_iam_role.example.arn
  description      = "Example with a load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_lb_listener.example.arn

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.example.id

  tls_config {
    server_name_to_verify = "example.com"
  }

  request_parameters = {
    "append:header.authforintegration" = "$context.authorizer.authorizerResponse"
    "overwrite:path"                   = "staticValueForIntegration"
  }

  response_parameters {
    status_code = 403
    mappings = {
      "append:header.auth" = "$context.authorizer.authorizerResponse"
    }
  }

  response_parameters {
    status_code = 200
    mappings = {
      "overwrite:statuscode" = "204"
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `apiId` - (Required) API identifier.
* `integrationType` - (Required) Integration type of an integration.
Valid values: `aws` (supported only for WebSocket APIs), `awsProxy`, `http` (supported only for WebSocket APIs), `httpProxy`, `mock` (supported only for WebSocket APIs). For an HTTP API private integration, use `httpProxy`.
* `connectionId` - (Optional) ID of the [VPC link](apigatewayv2_vpc_link.html) for a private integration. Supported only for HTTP APIs. Must be between 1 and 1024 characters in length.
* `connectionType` - (Optional) Type of the network connection to the integration endpoint. Valid values: `internet`, `vpcLink`. Default is `internet`.
* `contentHandlingStrategy` - (Optional) How to handle response payload content type conversions. Valid values: `convertToBinary`, `convertToText`. Supported only for WebSocket APIs.
* `credentialsArn` - (Optional) Credentials required for the integration, if any.
* `description` - (Optional) Description of the integration.
* `integrationMethod` - (Optional) Integration's HTTP method. Must be specified if `integrationType` is not `mock`.
* `integrationSubtype` - (Optional) AWS service action to invoke. Supported only for HTTP APIs when `integrationType` is `awsProxy`. See the [AWS service integration reference](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html) documentation for supported values. Must be between 1 and 128 characters in length.
* `integrationUri` - (Optional) URI of the Lambda function for a Lambda proxy integration, when `integrationType` is `awsProxy`.
For an `http` integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service.
* `passthroughBehavior` - (Optional) Pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the `requestTemplates` attribute.
Valid values: `whenNoMatch`, `whenNoTemplates`, `never`. Default is `whenNoMatch`. Supported only for WebSocket APIs.
* `payloadFormatVersion` - (Optional) The [format of the payload](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format) sent to an integration. Valid values: `10`, `20`. Default is `10`.
* `requestParameters` - (Optional) For WebSocket APIs, a key-value map specifying request parameters that are passed from the method request to the backend.
For HTTP APIs with a specified `integrationSubtype`, a key-value map specifying parameters that are passed to `awsProxy` integrations.
For HTTP APIs without a specified `integrationSubtype`, a key-value map specifying how to transform HTTP requests before sending them to the backend.
See the [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html) for details.
* `requestTemplates` - (Optional) Map of [Velocity](https://velocity.apache.org/) templates that are applied on the request payload based on the value of the Content-Type header sent by the client. Supported only for WebSocket APIs.
* `responseParameters` - (Optional) Mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs.
* `templateSelectionExpression` - (Optional) The [template selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-template-selection-expressions) for the integration.
* `timeoutMilliseconds` - (Optional) Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and between 50 and 30,000 milliseconds for HTTP APIs.
The default timeout is 29 seconds for WebSocket APIs and 30 seconds for HTTP APIs.
Terraform will only perform drift detection of its value when present in a configuration.
* `tlsConfig` - (Optional) TLS configuration for a private integration. Supported only for HTTP APIs.

The `responseParameters` object supports the following:

* `statusCode` - (Required) HTTP status code in the range 200-599.
* `mappings` - (Required) Key-value map. The key of this map identifies the location of the request parameter to change, and how to change it. The corresponding value specifies the new data for the parameter.
See the [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html) for details.

The `tlsConfig` object supports the following:

* `serverNameToVerify` - (Optional) If you specify a server name, API Gateway uses it to verify the hostname on the integration's certificate. The server name is also included in the TLS handshake to support Server Name Indication (SNI) or virtual hosting.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Integration identifier.
* `integrationResponseSelectionExpression` - The [integration response selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions) for the integration.

## Import

`awsApigatewayv2Integration` can be imported by using the API identifier and integration identifier, e.g.,

```
$ terraform import aws_apigatewayv2_integration.example aabbccddee/1122334
```

-> **Note:** The API Gateway managed integration created as part of [_quick_create_](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-basic-concept.html#apigateway-definition-quick-create) cannot be imported.

<!-- cache-key: cdktf-0.17.0-pre.15 input-895f24f6878c65a451ff9786f4ee9e03cbae7172a31a06634d7b82882c8f6d49 -->