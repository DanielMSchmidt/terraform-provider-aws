---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_integration"
description: |-
  Provides an HTTP Method Integration for an API Gateway Integration.
---

# Resource: aws_api_gateway_integration

Provides an HTTP Method Integration for an API Gateway Integration.

## Example Usage

```terraform
resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id   = aws_api_gateway_resource.MyDemoResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id          = aws_api_gateway_resource.MyDemoResource.id
  http_method          = aws_api_gateway_method.MyDemoMethod.http_method
  type                 = "MOCK"
  cache_key_parameters = ["method.request.path.param"]
  cache_namespace      = "foobar"
  timeout_milliseconds = 29000

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}
```

## Lambda integration

```terraform
# Variables
variable "myregion" {}

variable "accountId" {}

# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "myapi"
}

resource "aws_api_gateway_resource" "resource" {
  path_part   = "resource"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

resource "aws_lambda_function" "lambda" {
  filename      = "lambda.zip"
  function_name = "mylambda"
  role          = aws_iam_role.role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.7"

  source_code_hash = filebase64sha256("lambda.zip")
}

# IAM
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "myrole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
```

## VPC Link

```terraform
variable "name" {}
variable "subnet_id" {}

resource "aws_lb" "test" {
  name               = var.name
  internal           = true
  load_balancer_type = "network"
  subnets            = [var.subnet_id]
}

resource "aws_api_gateway_vpc_link" "test" {
  name        = var.name
  target_arns = [aws_lb.test.arn]
}

resource "aws_api_gateway_rest_api" "test" {
  name = var.name
}

resource "aws_api_gateway_resource" "test" {
  rest_api_id = aws_api_gateway_rest_api.test.id
  parent_id   = aws_api_gateway_rest_api.test.root_resource_id
  path_part   = "test"
}

resource "aws_api_gateway_method" "test" {
  rest_api_id   = aws_api_gateway_rest_api.test.id
  resource_id   = aws_api_gateway_resource.test.id
  http_method   = "GET"
  authorization = "NONE"

  request_models = {
    "application/json" = "Error"
  }
}

resource "aws_api_gateway_integration" "test" {
  rest_api_id = aws_api_gateway_rest_api.test.id
  resource_id = aws_api_gateway_resource.test.id
  http_method = aws_api_gateway_method.test.http_method

  request_templates = {
    "application/json" = ""
    "application/xml"  = "#set($inputRoot = $input.path('$'))\n{ }"
  }

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
    "integration.request.header.X-Foo"           = "'Bar'"
  }

  type                    = "HTTP"
  uri                     = "https://www.google.de"
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  content_handling        = "CONVERT_TO_TEXT"

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.test.id
}
```

## Argument Reference

The following arguments are supported:

* `restApiId` - (Required) ID of the associated REST API.
* `resourceId` - (Required) API resource ID.
* `httpMethod` - (Required) HTTP method (`get`, `post`, `put`, `delete`, `head`, `option`, `any`)
  when calling the associated resource.
* `integrationHttpMethod` - (Optional) Integration HTTP method
  (`get`, `post`, `put`, `delete`, `head`, `optioNs`, `any`, `patch`) specifying how API Gateway will interact with the back end.
  **Required** if `type` is `aws`, `awsProxy`, `http` or `httpProxy`.
  Not all methods are compatible with all `aws` integrations.
  e.g., Lambda function [can only be invoked](https://github.com/awslabs/aws-apigateway-importer/issues/9#issuecomment-129651005) via `post`.
* `type` - (Required) Integration input's [type](https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/). Valid values are `http` (for HTTP backends), `mock` (not calling any real backend), `aws` (for AWS services), `awsProxy` (for Lambda proxy integration) and `httpProxy` (for HTTP proxy integration). An `http` or `httpProxy` integration with a `connectionType` of `vpcLink` is referred to as a private integration and uses a VpcLink to connect API Gateway to a network load balancer of a VPC.
* `connectionType` - (Optional) Integration input's [connectionType](https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/#connectionType). Valid values are `internet` (default for connections through the public routable internet), and `vpcLink` (for private connections between API Gateway and a network load balancer in a VPC).
* `connectionId` - (Optional) ID of the VpcLink used for the integration. **Required** if `connectionType` is `vpcLink`
* `uri` - (Optional) Input's URI. **Required** if `type` is `aws`, `awsProxy`, `http` or `httpProxy`.
  For HTTP integrations, the URI must be a fully formed, encoded HTTP(S) URL according to the RFC-3986 specification . For AWS integrations, the URI should be of the form `arn:aws:apigateway:{region}:{subdomainService|service}:{path|action}/{serviceApi}`. `region`, `subdomain` and `service` are used to determine the right endpoint.
  e.g., `arn:aws:apigateway:euWest1:lambda:path/20150331/functions/arn:aws:lambda:euWest1:012345678901:function:myFunc/invocations`. For private integrations, the URI parameter is not used for routing requests to your endpoint, but is used for setting the Host header and for certificate validation.
* `credentials` - (Optional) Credentials required for the integration. For `aws` integrations, 2 options are available. To specify an IAM Role for Amazon API Gateway to assume, use the role's ARN. To require that the caller's identity be passed through from the request, specify the string `arn:aws:iam::\*:user/\*`.
* `requestTemplates` - (Optional) Map of the integration's request templates.
* `requestParameters` - (Optional) Map of request query string parameters and headers that should be passed to the backend responder.
  For example: `request_parameters = { "integration.request.header.X-Some-Other-Header" = "method.request.header.X-Some-Header" }`
* `passthroughBehavior` - (Optional) Integration passthrough behavior (`whenNoMatch`, `whenNoTemplates`, `never`).  **Required** if `requestTemplates` is used.
* `cacheKeyParameters` - (Optional) List of cache key parameters for the integration.
* `cacheNamespace` - (Optional) Integration's cache namespace.
* `contentHandling` - (Optional) How to handle request payload content type conversions. Supported values are `convertToBinary` and `convertToText`. If this property is not defined, the request payload will be passed through from the method request to integration request without modification, provided that the passthroughBehaviors is configured to support payload pass-through.
* `timeoutMilliseconds` - (Optional) Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds.
* `tlsConfig` - (Optional) TLS configuration. See below.

### tls_config Configuration Block

The `tlsConfig` configuration block supports the following arguments:

* `insecureSkipVerification` - (Optional) Whether or not API Gateway skips verification that the certificate for an integration endpoint is issued by a [supported certificate authority](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-supported-certificate-authorities-for-http-endpoints.html). This isn’t recommended, but it enables you to use certificates that are signed by private certificate authorities, or certificates that are self-signed. If enabled, API Gateway still performs basic certificate validation, which includes checking the certificate's expiration date, hostname, and presence of a root certificate authority. Supported only for `http` and `httpProxy` integrations.

## Attributes Reference

No additional attributes are exported.

## Import

`awsApiGatewayIntegration` can be imported using `restApiId/resourceId/httpMethod`, e.g.,

```
$ terraform import aws_api_gateway_integration.example 12345abcde/67890fghij/GET
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-5f0767494937cbd26974b191387927844f7fcb12706366afefb74ebc1db28588 -->