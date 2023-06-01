---
subcategory: "Backup"
layout: "aws"
page_title: "AWS: aws_backup_vault"
description: |-
  Provides an AWS Backup vault resource.
---

# Resource: aws_backup_vault

Provides an AWS Backup vault resource.

## Example Usage

```terraform
resource "aws_backup_vault" "example" {
  name        = "example_backup_vault"
  kms_key_arn = aws_kms_key.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `forceDestroy` - (Optional, Default: `false`) A boolean that indicates that all recovery points stored in the vault are deleted so that the vault can be destroyed without error.
* `kmsKeyArn` - (Optional) The server-side encryption key that is used to protect your backups.
* `name` - (Required) Name of the backup vault to create.
* `tags` - (Optional) Metadata that you can assign to help organize the resources that you create. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The name of the vault.
* `arn` - The ARN of the vault.
* `recoveryPoints` - The number of recovery points that are stored in a backup vault.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `delete` - (Default `10M`)

## Import

Backup vault can be imported using the `name`, e.g.,

```
$ terraform import aws_backup_vault.test-vault TestVault
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-9d09c329ac118420b549aff5bc8bde2408e1327436292223333be6065eceb9c6 -->