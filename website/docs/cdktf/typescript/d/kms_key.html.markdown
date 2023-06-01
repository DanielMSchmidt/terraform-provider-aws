---
subcategory: "KMS (Key Management)"
layout: "aws"
page_title: "AWS: aws_kms_key"
description: |-
  Get information on a AWS Key Management Service (KMS) Key
---

# aws_kms_key

Use this data source to get detailed information about
the specified KMS Key with flexible key id input.
This can be useful to reference key alias
without having to hard code the ARN as input.

## Example Usage

```terraform
data "aws_kms_key" "by_alias" {
  key_id = "alias/my-key"
}

data "aws_kms_key" "by_id" {
  key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
}

data "aws_kms_key" "by_alias_arn" {
  key_id = "arn:aws:kms:us-east-1:111122223333:alias/my-key"
}

data "aws_kms_key" "by_key_arn" {
  key_id = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
}
```

## Argument Reference

* `keyId` - (Required) Key identifier which can be one of the following format:
    * Key ID. E.g: `1234Abcd12Ab34Cd56Ef1234567890Ab`
    * Key ARN. E.g.: `arn:aws:kms:usEast1:111122223333:key/1234Abcd12Ab34Cd56Ef1234567890Ab`
    * Alias name. E.g.: `alias/myKey`
    * Alias ARN: E.g.: `arn:aws:kms:usEast1:111122223333:alias/myKey`
* `grantTokens` - (Optional) List of grant tokens

## Attributes Reference

* `id`: The globally unique identifier for the key
* `arn`: The ARN of the key
* `awsAccountId`: The twelve-digit account ID of the AWS account that owns the key
* `cloudHsmClusterId`: The cluster ID of the AWS CloudHSM cluster that contains the key material for the KMS key.
* `creationDate`: The date and time when the key was created
* `customKeyStoreId`: A unique identifier for the custom key store that contains the KMS key.
* `customerMasterKeySpec`: Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports
* `deletionDate`: The date and time after which AWS KMS deletes the key. This value is present only when `keyState` is `pendingDeletion`, otherwise this value is 0
* `description`: The description of the key.
* `enabled`: Specifies whether the key is enabled. When `keyState` is `enabled` this value is true, otherwise it is false
* `expirationModel`: Specifies whether the Key's key material expires. This value is present only when `origin` is `external`, otherwise this value is empty
* `keyManager`: The key's manager
* `keySpec`: Describes the type of key material in the KMS key.
* `keyState`: The state of the key
* `keyUsage`: Specifies the intended use of the key
* `multiRegion`: Indicates whether the KMS key is a multi-Region (`true`) or regional (`false`) key.
* `multiRegionConfiguration`: Lists the primary and replica keys in same multi-Region key. Present only when the value of `multiRegion` is `true`.
* `origin`: When this value is `awsKms`, AWS KMS created the key material. When this value is `external`, the key material was imported from your existing key management infrastructure or the CMK lacks key material
* `pendingDeletionWindowInDays`: The waiting period before the primary key in a multi-Region key is deleted.
* `validTo`: The time at which the imported key material expires. This value is present only when `origin` is `external` and whose `expirationModel` is `keyMaterialExpires`, otherwise this value is 0
* `xksKeyConfiguration`: Information about the external key that is associated with a KMS key in an external key store.

The `multiRegionConfiguration` object supports the following:

* `multiRegionKeyType`: Indicates whether the KMS key is a `primary` or `replica` key.
* `primaryKey`: The key ARN and Region of the primary key. This is the current KMS key if it is the primary key.
* `replicaKeys`: The key ARNs and Regions of all replica keys. Includes the current KMS key if it is a replica key.

The `primaryKey` and `replicaKeys` objects support the following:

* `arn`: The key ARN of a primary or replica key of a multi-Region key.
* `region`: The AWS Region of a primary or replica key in a multi-Region key.

<!-- cache-key: cdktf-0.17.0-pre.15 input-8a66d27df0c5640e77081e8f31e7d5272ea449ab73576f6faa7abe869b871bbf -->