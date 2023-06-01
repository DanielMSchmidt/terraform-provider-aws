---
subcategory: "API Gateway"
layout: "aws"
page_title: "AWS: aws_api_gateway_authorizers"
description: |-
  Provides details about multiple API Gateway Authorizers.
---

# Data Source: aws_api_gateway_authorizers

Provides details about multiple API Gateway Authorizers.

## Example Usage

```terraform
data "aws_api_gateway_authorizers" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
}
```

## Argument Reference

The following arguments are required:

* `rest_api_id` - (Required) ID of the associated REST API.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `ids` - List of Authorizer identifiers.

<!-- cache-key: cdktf-0.17.0-pre.15 input-5a2fd10607e7736732b5d2329a16a45b2c44f371660c45e2a4cefab264648cc7 -->