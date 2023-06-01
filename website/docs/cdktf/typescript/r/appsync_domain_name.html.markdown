---
subcategory: "AppSync"
layout: "aws"
page_title: "AWS: aws_appsync_domain_name"
description: |-
  Provides an AppSync Domain Name.
---

# Resource: aws_appsync_domain_name

Provides an AppSync Domain Name.

## Example Usage

```terraform
resource "aws_appsync_domain_name" "example" {
  domain_name     = "api.example.com"
  certificate_arn = aws_acm_certificate.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `certificateArn` - (Required) ARN of the certificate. This can be an Certificate Manager (ACM) certificate or an Identity and Access Management (IAM) server certificate. The certifiacte must reside in us-east-1.
* `description` - (Optional)  A description of the Domain Name.
* `domainName` - (Required) Domain name.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Appsync Domain Name.
* `appsyncDomainName` - Domain name that AppSync provides.
* `hostedZoneId` - ID of your Amazon Route 53 hosted zone.

## Import

`awsAppsyncDomainName` can be imported using the AppSync domain name, e.g.,

```
$ terraform import aws_appsync_domain_name.example example.com
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-e455ac2d8ada533e18e13e02868fe7031b5817e951d0091503bef17ec7f525bb -->