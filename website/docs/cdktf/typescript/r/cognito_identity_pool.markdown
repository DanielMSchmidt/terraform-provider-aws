---
subcategory: "Cognito Identity"
layout: "aws"
page_title: "AWS: aws_cognito_identity_pool"
description: |-
  Provides an AWS Cognito Identity Pool.
---

# Resource: aws_cognito_identity_pool

Provides an AWS Cognito Identity Pool.

## Example Usage

```terraform
resource "aws_iam_saml_provider" "default" {
  name                   = "my-saml-provider"
  saml_metadata_document = file("saml-metadata.xml")
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "identity pool"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = "6lhlkkfbfb4q5kpp90urffae"
    provider_name           = "cognito-idp.us-east-1.amazonaws.com/us-east-1_Tv0493apJ"
    server_side_token_check = false
  }

  cognito_identity_providers {
    client_id               = "7kodkvfqfb4qfkp39eurffae"
    provider_name           = "cognito-idp.us-east-1.amazonaws.com/eu-west-1_Zr231apJu"
    server_side_token_check = false
  }

  supported_login_providers = {
    "graph.facebook.com"  = "7346241598935552"
    "accounts.google.com" = "123456789012.apps.googleusercontent.com"
  }

  saml_provider_arns           = [aws_iam_saml_provider.default.arn]
  openid_connect_provider_arns = ["arn:aws:iam::123456789012:oidc-provider/id.example.com"]
}
```

## Argument Reference

The Cognito Identity Pool argument layout is a structure composed of several sub-resources - these resources are laid out below.

* `identityPoolName` (Required) - The Cognito Identity Pool name.
* `allowUnauthenticatedIdentities` (Required) - Whether the identity pool supports unauthenticated logins or not.
* `allowClassicFlow` (Optional) - Enables or disables the classic / basic authentication flow. Default is `false`.
* `developerProviderName` (Optional) - The "domain" by which Cognito will refer to your users. This name acts as a placeholder that allows your
backend and the Cognito service to communicate about the developer provider.
* `cognitoIdentityProviders` (Optional) - An array of [Amazon Cognito Identity user pools](#cognito-identity-providers) and their client IDs.
* `openidConnectProviderArns` (Optional) - Set of OpendID Connect provider ARNs.
* `samlProviderArns` (Optional) - An array of Amazon Resource Names (ARNs) of the SAML provider for your identity.
* `supportedLoginProviders` (Optional) - Key-Value pairs mapping provider names to provider app IDs.
* `tags` - (Optional) A map of tags to assign to the Identity Pool. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

#### Cognito Identity Providers

* `clientId` (Optional) - The client ID for the Amazon Cognito Identity User Pool.
* `providerName` (Optional) - The provider name for an Amazon Cognito Identity User Pool.
* `serverSideTokenCheck` (Optional) - Whether server-side token validation is enabled for the identity provider’s token or not.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - An identity pool ID, e.g. `usWest2Abc123`.
* `arn` - The ARN of the identity pool.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Cognito Identity Pool can be imported using its ID, e.g.,

```
$ terraform import aws_cognito_identity_pool.mypool us-west-2_abc123
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-36fe5f4bf6198ffa510d22980dc8122295a498be73026a9f3713cb1cf7401718 -->