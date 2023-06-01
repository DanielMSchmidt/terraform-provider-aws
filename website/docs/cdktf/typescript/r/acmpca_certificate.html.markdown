---
subcategory: "ACM PCA (Certificate Manager Private Certificate Authority)"
layout: "aws"
page_title: "AWS: aws_acmpca_certificate"
description: |-
  Provides a resource to issue a certificate using AWS Certificate Manager Private Certificate Authority (ACM PCA)
---

# Resource: aws_acmpca_certificate

Provides a resource to issue a certificate using AWS Certificate Manager Private Certificate Authority (ACM PCA).

Certificates created using `awsAcmpcaCertificate` are not eligible for automatic renewal,
and must be replaced instead.
To issue a renewable certificate using an ACM PCA, create a [`awsAcmCertificate`](acm_certificate.html)
with the parameter `certificateAuthorityArn`.

## Example Usage

### Basic

```terraform
resource "aws_acmpca_certificate" "example" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.example.arn
  certificate_signing_request = tls_cert_request.csr.cert_request_pem
  signing_algorithm           = "SHA256WITHRSA"
  validity {
    type  = "YEARS"
    value = 1
  }
}

resource "aws_acmpca_certificate_authority" "example" {
  private_certificate_configuration {
    key_algorithm     = "RSA_4096"
    signing_algorithm = "SHA512WITHRSA"

    subject {
      common_name = "example.com"
    }
  }

  permanent_deletion_time_in_days = 7
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "tls_cert_request" "csr" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.key.private_key_pem

  subject {
    common_name = "example"
  }
}
```

## Argument Reference

The following arguments are supported:

* `certificateAuthorityArn` - (Required) ARN of the certificate authority.
* `certificateSigningRequest` - (Required) Certificate Signing Request in PEM format.
* `signingAlgorithm` - (Required) Algorithm to use to sign certificate requests. Valid values: `sha256Withrsa`, `sha256Withecdsa`, `sha384Withrsa`, `sha384Withecdsa`, `sha512Withrsa`, `sha512Withecdsa`.
* `validity` - (Required) Configures end of the validity period for the certificate. See [validity block](#validity-block) below.
* `templateArn` - (Optional) Template to use when issuing a certificate.
  See [ACM PCA Documentation](https://docs.aws.amazon.com/privateca/latest/userguide/UsingTemplates.html) for more information.
* `apiPassthrough` - (Optional) Specifies X.509 certificate information to be included in the issued certificate. To use with API Passthrough templates

### validity block

* `type` - (Required) Determines how `value` is interpreted. Valid values: `days`, `months`, `years`, `absolute`, `endDate`.
* `value` - (Required) If `type` is `days`, `months`, or `years`, the relative time until the certificate expires. If `type` is `absolute`, the date in seconds since the Unix epoch. If `type` is `endDate`, the  date in RFC 3339 format.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the certificate.
* `certificate` - PEM-encoded certificate value.
* `certificateChain` - PEM-encoded certificate chain that includes any intermediate certificates and chains up to root CA.

## Import

ACM PCA Certificates can be imported using their ARN, e.g.,

```
$ terraform import aws_acmpca_certificate.cert arn:aws:acm-pca:eu-west-1:675225743824:certificate-authority/08319ede-83g9-1400-8f21-c7d12b2b6edb/certificate/a4e9c2aa4bcfab625g1b9136464cd3a
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-70c7281b0f199e703af2c06b31817e6e5ed6539fb304bd0f3e565fb91914b274 -->