---
subcategory: "API Gateway V2"
layout: "aws"
page_title: "AWS: aws_apigatewayv2_export"
description: |-
  Exports a definition of an API in a particular output format and specification.
---

# Data Source: aws_apigatewayv2_export

Exports a definition of an API in a particular output format and specification.

## Example Usage

```terraform
data "aws_apigatewayv2_export" "test" {
  api_id        = aws_apigatewayv2_route.test.api_id
  specification = "OAS30"
  output_type   = "JSON"
}
```

## Argument Reference

The following arguments are supported:

* `apiId` - (Required) API identifier.
* `specification` - (Required) Version of the API specification to use. `oas30`, for OpenAPI 3.0, is the only supported value.
* `outputType` - (Required) Output type of the exported definition file. Valid values are `json` and `yaml`.
* `exportVersion` - (Optional) Version of the API Gateway export algorithm. API Gateway uses the latest version by default. Currently, the only supported version is `10`.
* `includeExtensions` - (Optional) Whether to include API Gateway extensions in the exported API definition. API Gateway extensions are included by default.
* `stageName` - (Optional) Name of the API stage to export. If you don't specify this property, a representation of the latest API configuration is exported.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - API identifier.
* `body` - ID of the API.

<!-- cache-key: cdktf-0.17.0-pre.15 input-634b2a5ce41c1192f44c02a827bffb870b5cc181e05023be173d8e16f410509f -->