---
subcategory: "Secrets Manager"
layout: "aws"
page_title: "AWS: aws_secretsmanager_secret_version"
description: |-
  Retrieve information about a Secrets Manager secret version including its secret value
---

# Data Source: aws_secretsmanager_secret_version

Retrieve information about a Secrets Manager secret version, including its secret value. To retrieve secret metadata, see the [`awsSecretsmanagerSecret` data source](/docs/providers/aws/d/secretsmanager_secret.html).

## Example Usage

### Retrieve Current Secret Version

By default, this data sources retrieves information based on the `awscurrent` staging label.

```terraform
data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.example.id
}
```

### Retrieve Specific Secret Version

```terraform
data "aws_secretsmanager_secret_version" "by-version-stage" {
  secret_id     = data.aws_secretsmanager_secret.example.id
  version_stage = "example"
}
```

### Handling Key-Value Secret Strings in JSON

Reading key-value pairs from JSON back into a native Terraform map can be accomplished in Terraform 0.12 and later with the [`jsondecode()` function](https://www.terraform.io/docs/configuration/functions/jsondecode.html):

```terraform
output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)["key1"]
}
```

## Argument Reference

* `secretId` - (Required) Specifies the secret containing the version that you want to retrieve. You can specify either the ARN or the friendly name of the secret.
* `versionId` - (Optional) Specifies the unique identifier of the version of the secret that you want to retrieve. Overrides `versionStage`.
* `versionStage` - (Optional) Specifies the secret version that you want to retrieve by the staging label attached to the version. Defaults to `awscurrent`.

## Attributes Reference

* `arn` - ARN of the secret.
* `id` - Unique identifier of this version of the secret.
* `secretString` - Decrypted part of the protected secret information that was originally provided as a string.
* `secretBinary` - Decrypted part of the protected secret information that was originally provided as a binary.
* `versionId` - Unique identifier of this version of the secret.

<!-- cache-key: cdktf-0.17.0-pre.15 input-ab40f7954616896f85c70bbc923eba8818545363c7db1e0902d5b7d57e58876e -->