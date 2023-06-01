---
subcategory: "CodeStar Connections"
layout: "aws"
page_title: "AWS: aws_codestarconnections_connection"
description: |-
  Provides details about CodeStar Connection
---

# Data Source: aws_codestarconnections_connection

Provides details about CodeStar Connection.

## Example Usage

### By ARN

```terraform
data "aws_codestarconnections_connection" "example" {
  arn = aws_codestarconnections_connection.example.arn
}
```

### By Name

```terraform
data "aws_codestarconnections_connection" "example" {
  name = aws_codestarconnections_connection.example.name
}
```

## Argument Reference

The following arguments are supported:

* `arn` - (Optional) CodeStar Connection ARN.
* `name` - (Optional) CodeStar Connection name.

~> **NOTE:** When both `arn` and `name` are specified, `arn` takes precedence.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `connectionStatus` - CodeStar Connection status. Possible values are `pending`, `available` and `error`.
* `id` - CodeStar Connection ARN.
* `hostArn` - ARN of the host associated with the connection.
* `name` - Name of the CodeStar Connection. The name is unique in the calling AWS account.
* `providerType` - Name of the external provider where your third-party code repository is configured. Possible values are `bitbucket` and `gitHub`. For connections to a GitHub Enterprise Server instance, you must create an [aws_codestarconnections_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_host) resource and use `hostArn` instead.
* `tags` - Map of key-value resource tags to associate with the resource.

<!-- cache-key: cdktf-0.17.0-pre.15 input-2ac0a0e410f8252d156d4b689b37b1b97fbd8daa0c2f28db6b6ce7e8ae985fcb -->