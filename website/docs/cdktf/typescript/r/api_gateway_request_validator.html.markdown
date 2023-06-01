---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_request_validator"
description: |-
  Manages an API Gateway Request Validator.
---

# Resource: aws_api_gateway_request_validator

Manages an API Gateway Request Validator.

## Example Usage

```terraform
resource "aws_api_gateway_request_validator" "example" {
  name                        = "example"
  rest_api_id                 = aws_api_gateway_rest_api.example.id
  validate_request_body       = true
  validate_request_parameters = true
}
```

## Argument Reference

The following argument is supported:

* `name` - (Required) Name of the request validator
* `restApiId` - (Required) ID of the associated Rest API
* `validateRequestBody` - (Optional) Boolean whether to validate request body. Defaults to `false`.
* `validateRequestParameters` - (Optional) Boolean whether to validate request parameters. Defaults to `false`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Unique ID of the request validator

## Import

`awsApiGatewayRequestValidator` can be imported using `restApiId/requestValidatorId`, e.g.,

```
$ terraform import aws_api_gateway_request_validator.example 12345abcde/67890fghij
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b27edd4bc5259e64d67f6f98dbd0210339b3da4a31af76042cf4520a199ab5d1 -->