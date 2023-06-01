---
subcategory: "Cognito IDP (Identity Provider)"
layout: "aws"
page_title: "AWS: aws_cognito_user_pool_clients"
description: |-
  Get list of cognito user pool clients connected to user pool.
---

# Data Source: aws_cognito_user_pool_clients

Use this data source to get a list of Cognito user pools clients for a Cognito IdP user pool.

## Example Usage

```terraform
data "aws_cognito_user_pool_clients" "main" {
  user_pool_id = aws_cognito_user_pool.main.id
}
```

## Argument Reference

* `user_pool_id` - (Required) Cognito user pool ID.

## Attributes Reference

* `client_ids` - List of Cognito user pool client IDs.
* `client_names` - List of Cognito user pool client names.

<!-- cache-key: cdktf-0.17.0-pre.15 input-f67c677924af5346f820697788d6741806373b1936376bff34ce2fe35dba7cce -->