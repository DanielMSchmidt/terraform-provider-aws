---
subcategory: "DMS (Database Migration)"
layout: "aws"
page_title: "AWS: aws_dms_certificate"
description: |-
  Terraform data source for managing an AWS DMS (Database Migration) Certificate.
---

# Data Source: aws_dms_certificate

Terraform data source for managing an AWS DMS (Database Migration) Certificate.

## Example Usage

### Basic Usage

```terraform
data "aws_dms_certificate" "example" {
  certificate_id = aws_dms_certificate.test.certificate_id
}
```

## Argument Reference

The following arguments are required:

* `certificateId` - (Required) A customer-assigned name for the certificate. Identifiers must begin with a letter and must contain only ASCII letters, digits, and hyphens. They can't end with a hyphen or contain two consecutive hyphens.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `certificateCreationDate` - The date that the certificate was created.
* `certificatePem` - The contents of a .pem file, which contains an X.509 certificate.
* `certificateOwner` - The owner of the certificate.
* `certificateArn` - The Amazon Resource Name (ARN) for the certificate.
* `certificateWallet` - The owner of the certificate.
* `keyLength` - The key length of the cryptographic algorithm being used.
* `signingAlgorithm` - The algorithm for the certificate.
* `validFromDate` - The beginning date that the certificate is valid.
* `validToDate` - The final date that the certificate is valid.

<!-- cache-key: cdktf-0.17.0-pre.15 input-fbbf16af4c0b831b139416cb1706e0dd4d29293c5b1a5c524e6d021f8756384b -->