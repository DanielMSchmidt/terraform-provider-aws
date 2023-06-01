---
subcategory: "SSO Identity Store"
layout: "aws"
page_title: "AWS: aws_identitystore_user"
description: |-
  Terraform resource for managing an AWS Identity Store User.
---

# Resource: aws_identitystore_user

This resource manages a User resource within an Identity Store.

-> **Note:** If you use an external identity provider or Active Directory as your identity source,
use this resource with caution. IAM Identity Center does not support outbound synchronization,
so your identity source does not automatically update with the changes that you make to
users using this resource.

## Example Usage

### Basic Usage

```terraform
resource "aws_identitystore_user" "example" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]

  display_name = "John Doe"
  user_name    = "johndoe"

  name {
    given_name  = "John"
    family_name = "Doe"
  }

  emails {
    value = "john@example.com"
  }
}
```

## Argument Reference

-> Unless specified otherwise, all fields can contain up to 1024 characters of free-form text.

The following arguments are required:

* `displayName` - (Required) The name that is typically displayed when the user is referenced.
* `identityStoreId` - (Required, Forces new resource) The globally unique identifier for the identity store that this user is in.
* `name` - (Required) Details about the user's full name. Detailed below.
* `userName` - (Required, Forces new resource) A unique string used to identify the user. This value can consist of letters, accented characters, symbols, numbers, and punctuation. This value is specified at the time the user is created and stored as an attribute of the user object in the identity store. The limit is 128 characters.

The following arguments are optional:

* `addresses` - (Optional) Details about the user's address. At most 1 address is allowed. Detailed below.
* `emails` - (Optional) Details about the user's email. At most 1 email is allowed. Detailed below.
* `locale` - (Optional) The user's geographical region or location.
* `nickname` - (Optional) An alternate name for the user.
* `phoneNumbers` - (Optional) Details about the user's phone number. At most 1 phone number is allowed. Detailed below.
* `preferredLanguage` - (Optional) The preferred language of the user.
* `profileUrl` - (Optional) An URL that may be associated with the user.
* `timezone` - (Optional) The user's time zone.
* `title` - (Optional) The user's title.
* `userType` - (Optional) The user type.

### addresses Configuration Block

* `country` - (Optional) The country that this address is in.
* `formatted` - (Optional) The name that is typically displayed when the address is shown for display.
* `locality` - (Optional) The address locality.
* `postalCode` - (Optional) The postal code of the address.
* `primary` - (Optional) When `true`, this is the primary address associated with the user.
* `region` - (Optional) The region of the address.
* `streetAddress` - (Optional) The street of the address.
* `type` - (Optional) The type of address.

### emails Configuration Block

* `primary` - (Optional) When `true`, this is the primary email associated with the user.
* `type` - (Optional) The type of email.
* `value` - (Optional) The email address. This value must be unique across the identity store.

### name Configuration Block

The following arguments are required:

* `familyName` - (Required) The family name of the user.
* `givenName` - (Required) The given name of the user.

The following arguments are optional:

* `formatted` - (Optional) The name that is typically displayed when the name is shown for display.
* `honorificPrefix` - (Optional) The honorific prefix of the user.
* `honorificSuffix` - (Optional) The honorific suffix of the user.
* `middleName` - (Optional) The middle name of the user.

### phone_numbers Configuration Block

* `primary` - (Optional) When `true`, this is the primary phone number associated with the user.
* `type` - (Optional) The type of phone number.
* `value` - (Optional) The user's phone number.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `externalIds` - A list of identifiers issued to this resource by an external identity provider.
    * `id` - The identifier issued to this resource by an external identity provider.
    * `issuer` - The issuer for an external identifier.
* `userId` - The identifier for this user in the identity store.

## Import

An Identity Store User can be imported using the combination `identityStoreId/userId`. For example:

```
$ terraform import aws_identitystore_user.example d-9c6705e95c/065212b4-9061-703b-5876-13a517ae2a7c
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-d702601e2f243d11d38c4b20ef9cefb8471268869f0970d420a04c3b6729d6e1 -->