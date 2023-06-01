---
subcategory: "Cognito IDP (Identity Provider)"
layout: "aws"
page_title: "AWS: aws_cognito_user_pool_ui_customization"
description: |-
  Provides a Cognito User Pool UI Customization resource.
---

# Resource: aws_cognito_user_pool_ui_customization

Provides a Cognito User Pool UI Customization resource.

~> **Note:** To use this resource, the user pool must have a domain associated with it. For more information, see the Amazon Cognito Developer Guide on [Customizing the Built-in Sign-In and Sign-up Webpages](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-app-ui-customization.html).

## Example Usage

### UI customization settings for a single client

```terraform
resource "aws_cognito_user_pool" "example" {
  name = "example"
}

resource "aws_cognito_user_pool_domain" "example" {
  domain       = "example"
  user_pool_id = aws_cognito_user_pool.example.id
}

resource "aws_cognito_user_pool_client" "example" {
  name         = "example"
  user_pool_id = aws_cognito_user_pool.example.id
}

resource "aws_cognito_user_pool_ui_customization" "example" {
  client_id = aws_cognito_user_pool_client.example.id

  css        = ".label-customizable {font-weight: 400;}"
  image_file = filebase64("logo.png")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  user_pool_id = aws_cognito_user_pool_domain.example.user_pool_id
}
```

### UI customization settings for all clients

```terraform
resource "aws_cognito_user_pool" "example" {
  name = "example"
}

resource "aws_cognito_user_pool_domain" "example" {
  domain       = "example"
  user_pool_id = aws_cognito_user_pool.example.id
}

resource "aws_cognito_user_pool_ui_customization" "example" {
  css        = ".label-customizable {font-weight: 400;}"
  image_file = filebase64("logo.png")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  user_pool_id = aws_cognito_user_pool_domain.example.user_pool_id
}
```

## Argument Reference

The following arguments are supported:

* `clientId` (Optional) The client ID for the client app. Defaults to `all`. If `all` is specified, the `css` and/or `imageFile` settings will be used for every client that has no UI customization set previously.
* `css` (Optional) - The CSS values in the UI customization, provided as a String. At least one of `css` or `imageFile` is required.
* `imageFile` (Optional) - The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of `css` or `imageFile` is required.
* `userPoolId` (Required) - The user pool ID for the user pool.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `creationDate` - The creation date in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) for the UI customization.
* `cssVersion` - The CSS version number.
* `imageUrl` - The logo image URL for the UI customization.
* `lastModifiedDate` - The last-modified date in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) for the UI customization.

## Import

Cognito User Pool UI Customizations can be imported using the `userPoolId` and `clientId` separated by `,`, e.g.,

```
$ terraform import aws_cognito_user_pool_ui_customization.example us-west-2_ZCTarbt5C,12bu4fuk3mlgqa2rtrujgp6egq
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b6fa0a438034314c134727ea25408c51d556e325454b06f48dffffeaddbc6de2 -->