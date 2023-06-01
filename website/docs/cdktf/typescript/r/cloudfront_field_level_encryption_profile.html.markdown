---
subcategory: "CloudFront"
layout: "aws"
page_title: "AWS: aws_cloudfront_field_level_encryption_profile"
description: |-
  Provides a CloudFront Field-level Encryption Profile resource.
---

# Resource: aws_cloudfront_field_level_encryption_profile

Provides a CloudFront Field-level Encryption Profile resource.

## Example Usage

```terraform
resource "aws_cloudfront_public_key" "example" {
  comment     = "test public key"
  encoded_key = file("public_key.pem")
  name        = "test_key"
}

resource "aws_cloudfront_field_level_encryption_profile" "test" {
  comment = "test comment"
  name    = "test profile"

  encryption_entities {
    items {
      public_key_id = aws_cloudfront_public_key.example.id
      provider_id   = "test provider"

      field_patterns {
        items = ["DateOfBirth"]
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the Field Level Encryption Profile.
* `comment` - (Optional) An optional comment about the Field Level Encryption Profile.
* `encryptionEntities` - (Required) The [encryption entities](#encryption-entities) config block for field-level encryption profiles that contains an attribute `items` which includes the encryption key and field pattern specifications.

### Encryption Entities

* `publicKeyId` - (Required) The public key associated with a set of field-level encryption patterns, to be used when encrypting the fields that match the patterns.
* `providerId` - (Required) The provider associated with the public key being used for encryption.
* `fieldPatterns` - (Required) Object that contains an attribute `items` that contains the list of field patterns in a field-level encryption content type profile specify the fields that you want to be encrypted.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `callerReference` - Internal value used by CloudFront to allow future updates to the Field Level Encryption Profile.
* `etag` - The current version of the Field Level Encryption Profile. For example: `e2Qwruhapomqzl`.
* `id` - The identifier for the Field Level Encryption Profile. For example: `k3D5Eweudccxon`.

## Import

Cloudfront Field Level Encryption Profile can be imported using the `id`, e.g.

```
$ terraform import aws_cloudfront_field_level_encryption_profile.profile K3D5EWEUDCCXON
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-93cb3be649b23e6755a5107f6d1d997e51df3a40ac8dc61927a0963b571cca0a -->