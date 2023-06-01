---
subcategory: "SSO Identity Store"
layout: "aws"
page_title: "AWS: aws_identitystore_group"
description: |-
  Terraform resource for managing an AWS IdentityStore Group.
---

# Resource: aws_identitystore_group

Terraform resource for managing an AWS IdentityStore Group.

## Example Usage

### Basic Usage

```terraform
resource "aws_identitystore_group" "this" {
  display_name      = "Example group"
  description       = "Example description"
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
}
```

## Argument Reference

The following arguments are required:

* `identityStoreId` - (Required) The globally unique identifier for the identity store.

The following arguments are optional:

* `displayName` - (Optional) A string containing the name of the group. This value is commonly displayed when the group is referenced.
* `description` - (Optional) A string containing the description of the group.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `groupId` - The identifier of the newly created group in the identity store.
* `externalIds` - A list of external IDs that contains the identifiers issued to this resource by an external identity provider. See [External IDs](#external-ids) below.

### External IDs

* `id` - The identifier issued to this resource by an external identity provider.
* `issuer` - The issuer for an external identifier.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `60M`)
* `update` - (Default `180M`)
* `delete` - (Default `90M`)

## Import

An Identity Store Group can be imported using the combination `identityStoreId/groupId`. For example:

```
$ terraform import aws_identitystore_group.example d-9c6705e95c/b8a1c340-8031-7071-a2fb-7dc540320c30
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-9012d7d868e59f5e5ab68061b0083debdadc7eafa9c94e5e4cb19548db999ded -->