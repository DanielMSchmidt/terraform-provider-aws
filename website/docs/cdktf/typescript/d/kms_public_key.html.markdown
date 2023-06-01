---
subcategory: "KMS (Key Management)"
layout: "aws"
page_title: "AWS: aws_kms_public_key"
description: |-
  Get information on a KMS public key
---

# aws_kms_public_key

Use this data source to get the public key about the specified KMS Key with flexible key id input. This can be useful to reference key alias without having to hard code the ARN as input.

## Example Usage

```terraform
data "aws_kms_public_key" "by_alias" {
  key_id = "alias/my-key"
}

data "aws_kms_public_key" "by_id" {
  key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
}

data "aws_kms_public_key" "by_alias_arn" {
  key_id = "arn:aws:kms:us-east-1:111122223333:alias/my-key"
}

data "aws_kms_public_key" "by_key_arn" {
  key_id = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
}
```

## Argument Reference

The following arguments are supported:

* `keyId` - (Required) Key identifier which can be one of the following format:
    * Key ID. E.g - `1234Abcd12Ab34Cd56Ef1234567890Ab`
    * Key ARN. E.g. - `arn:aws:kms:usEast1:111122223333:key/1234Abcd12Ab34Cd56Ef1234567890Ab`
    * Alias name. E.g. - `alias/myKey`
    * Alias ARN - E.g. - `arn:aws:kms:usEast1:111122223333:alias/myKey`
* `grantTokens` - (Optional) List of grant tokens

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Key ARN of the asymmetric CMK from which the public key was downloaded.
* `customerMasterKeySpec` - Type of the public key that was downloaded.
* `encryptionAlgorithms` - Encryption algorithms that AWS KMS supports for this key. Only set when the `keyUsage` of the public key is `encryptDecrypt`.
* `id` - Key ARN of the asymmetric CMK from which the public key was downloaded.
* `keyUsage` - Permitted use of the public key. Valid values are `encryptDecrypt` or `signVerify`
* `publicKey` - Exported public key. The value is a DER-encoded X.509 public key, also known as SubjectPublicKeyInfo (SPKI), as defined in [RFC 5280](https://tools.ietf.org/html/rfc5280). The value is Base64-encoded.
* `publicKeyPem` - Exported public key. The value is Privacy Enhanced Mail (PEM) encoded.
* `signingAlgorithms` - Signing algorithms that AWS KMS supports for this key. Only set when the `keyUsage` of the public key is `signVerify`.

<!-- cache-key: cdktf-0.17.0-pre.15 input-ba1cbb53a438f0118652ab359cb722c76567423b7a6e00073b6afbf44b17e93c -->