---
subcategory: "API Gateway V2"
layout: "aws"
page_title: "AWS: aws_apigatewayv2_integration_response"
description: |-
  Manages an Amazon API Gateway Version 2 integration response.
---

# Resource: aws_apigatewayv2_integration_response

Manages an Amazon API Gateway Version 2 integration response.
More information can be found in the [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html).

## Example Usage

### Basic

```terraform
resource "aws_apigatewayv2_integration_response" "example" {
  api_id                   = aws_apigatewayv2_api.example.id
  integration_id           = aws_apigatewayv2_integration.example.id
  integration_response_key = "/200/"
}
```

## Argument Reference

The following arguments are supported:

* `apiId` - (Required) API identifier.
* `integrationId` - (Required) Identifier of the [`awsApigatewayv2Integration`](/docs/providers/aws/r/apigatewayv2_integration.html).
* `integrationResponseKey` - (Required) Integration response key.
* `contentHandlingStrategy` - (Optional) How to handle response payload content type conversions. Valid values: `convertToBinary`, `convertToText`.
* `responseTemplates` - (Optional) Map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client.
* `templateSelectionExpression` - (Optional) The [template selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-template-selection-expressions) for the integration response.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Integration response identifier.

## Import

`awsApigatewayv2IntegrationResponse` can be imported by using the API identifier, integration identifier and integration response identifier, e.g.,

```
$ terraform import aws_apigatewayv2_integration_response.example aabbccddee/1122334/998877
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-ac2572833eccef26b6aa0b2a3f741ecea2283c7935aea1e95e88eafabaccd23b -->