---
subcategory: "CodeArtifact"
layout: "aws"
page_title: "AWS: aws_codeartifact_authorization_token"
description: |-
    Provides details about a CodeArtifact Authorization Token
---

# Data Source: aws_codeartifact_authorization_token

The CodeArtifact Authorization Token data source generates a temporary authentication token for accessing repositories in a CodeArtifact domain.

## Example Usage

```terraform
data "aws_codeartifact_authorization_token" "test" {
  domain = aws_codeartifact_domain.test.domain
}
```

## Argument Reference

The following arguments are supported:

* `domain` - (Required) Name of the domain that is in scope for the generated authorization token.
* `domainOwner` - (Optional) Account number of the AWS account that owns the domain.
* `durationSeconds` - (Optional) Time, in seconds, that the generated authorization token is valid. Valid values are `0` and between `900` and `43200`.

## Attributes Reference

In addition to the argument above, the following attributes are exported:

* `authorizationToken` - Temporary authorization token.
* `expiration` - Time in UTC RFC3339 format when the authorization token expires.

<!-- cache-key: cdktf-0.17.0-pre.15 input-611c9a07a6c9faee4a8dbcaf514c99284d6f96205a0a47ace9e53ab1ba38932e -->