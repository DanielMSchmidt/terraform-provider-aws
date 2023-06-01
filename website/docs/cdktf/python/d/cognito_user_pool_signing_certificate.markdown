---
subcategory: "Cognito IDP (Identity Provider)"
layout: "aws"
page_title: "AWS: aws_cognito_user_pool_signing_certificate"
description: |-
  Get signing certificate of user pool
---

# Data Source: aws_cognito_user_pool_signing_certificate

Use this data source to get the signing certificate for a Cognito IdP user pool.

## Example Usage

```terraform
data "aws_cognito_user_pool_signing_certificate" "sc" {
  user_pool_id = aws_cognito_user_pool.my_pool.id
}
```

## Argument Reference

* `user_pool_id` - (Required) Cognito user pool ID.

## Attributes Reference

* `certificate` - Certificate string

<!-- cache-key: cdktf-0.17.0-pre.15 input-0b9ac6140269f65e613b612e3bba9b3f5bded260ee17ab4ecaffc4d25f679eb9 -->