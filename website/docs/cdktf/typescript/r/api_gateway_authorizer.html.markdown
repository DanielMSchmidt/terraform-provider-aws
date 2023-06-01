---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_authorizer"
description: |-
  Provides an API Gateway Authorizer.
---

# Resource: aws_api_gateway_authorizer

Provides an API Gateway Authorizer.

## Example Usage

```terraform
resource "aws_api_gateway_authorizer" "demo" {
  name                   = "demo"
  rest_api_id            = aws_api_gateway_rest_api.demo.id
  authorizer_uri         = aws_lambda_function.authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
}

resource "aws_api_gateway_rest_api" "demo" {
  name = "auth-demo"
}

data "aws_iam_role_policy_document" "invocation_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type       = "Service"
      identifier = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "invocation_role" {
  name               = "api_gateway_auth_invocation"
  path               = "/"
  assume_role_policy = data.aws_iam_role_policy_document.assume_role.json
}

data "aws_iam_policy_document" "invocation_policy" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.authorizer.arn]
  }
}

resource "aws_iam_role_policy" "invocation_policy" {
  name   = "default"
  role   = aws_iam_role.invocation_role.id
  policy = data.aws_iam_policy_document.invocation_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "demo-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_lambda_function" "authorizer" {
  filename      = "lambda-function.zip"
  function_name = "api_gateway_authorizer"
  role          = aws_iam_role.lambda.arn
  handler       = "exports.example"

  source_code_hash = filebase64sha256("lambda-function.zip")
}
```

## Argument Reference

The following arguments are supported:

* `authorizerUri` - (Optional, required for type `token`/`request`) Authorizer's Uniform Resource Identifier (URI). This must be a well-formed Lambda function URI in the form of `arn:aws:apigateway:{region}:lambda:path/{serviceApi}`,
 e.g., `arn:aws:apigateway:usWest2:lambda:path/20150331/functions/arn:aws:lambda:usWest2:012345678912:function:myFunction/invocations`
* `name` - (Required) Name of the authorizer
* `restApiId` - (Required) ID of the associated REST API
* `identitySource` - (Optional) Source of the identity in an incoming request. Defaults to `methodRequestHeaderAuthorization`. For `request` type, this may be a comma-separated list of values, including headers, query string parameters and stage variables - e.g., `"methodRequestHeaderSomeHeaderName,methodRequestQuerystringSomeQueryStringName,stageVariablesSomeStageVariableName"`
* `type` - (Optional) Type of the authorizer. Possible values are `token` for a Lambda function using a single authorization token submitted in a custom header, `request` for a Lambda function using incoming request parameters, or `cognitoUserPools` for using an Amazon Cognito user pool. Defaults to `token`.
* `authorizerCredentials` - (Optional) Credentials required for the authorizer. To specify an IAM Role for API Gateway to assume, use the IAM Role ARN.
* `authorizerResultTtlInSeconds` - (Optional) TTL of cached authorizer results in seconds. Defaults to `300`.
* `identityValidationExpression` - (Optional) Validation expression for the incoming identity. For `token` type, this value should be a regular expression. The incoming token from the client is matched against this expression, and will proceed if the token matches. If the token doesn't match, the client receives a 401 Unauthorized response.
* `providerArns` - (Optional, required for type `cognitoUserPools`) List of the Amazon Cognito user pool ARNs. Each element is of this format: `arn:aws:cognitoIdp:{region}:{accountId}:userpool/{userPoolId}`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the API Gateway Authorizer
* `id` - Authorizer identifier.

## Import

AWS API Gateway Authorizer can be imported using the `restApiId/authorizerId`, e.g.,

```sh
$ terraform import aws_api_gateway_authorizer.authorizer 12345abcde/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-6391ebe84107c4d7738b89f655a5281b28f2e4983472b608f77ad9e3edf83f1a -->