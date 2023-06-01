---
subcategory: "License Manager"
layout: "aws"
page_title: "AWS: aws_licensemanager_grant_accepter"
description: |-
  Accepts a License Manager grant resource.
---

# Resource: aws_licensemanager_grant_accepter

Accepts a License Manager grant. This allows for sharing licenses with other aws accounts.

## Example Usage

```terraform
resource "aws_licensemanager_grant_accepter" "test" {
  name = "arn:aws:license-manager::123456789012:grant:g-1cf9fba4ba2f42dcab11c686c4b4d329"
}
```

## Argument Reference

The following arguments are supported:

* `grantArn` - (Required) The ARN of the grant to accept.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The grant ARN (Same as `arn`).
* `arn` - The grant ARN.
* `name` - The Name of the grant.
* `allowedOperations` - A list of the allowed operations for the grant.
* `licenseArn` - The ARN of the license for the grant.
* `principal` - The target account for the grant.
* `homeRegion` - The home region for the license.
* `parentArn` - The parent ARN.
* `status` - The grant status.
* `version` - The grant version.

## Import

`awsLicensemanagerGrantAccepter` can be imported using the grant arn.

```shell
$ terraform import aws_licensemanager_grant_accepter.test arn:aws:license-manager::123456789012:grant:g-1cf9fba4ba2f42dcab11c686c4b4d329
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f614b63b4667048d16dde7e546dc52ea27e8891cc8ba492e073cf30b6da115fe -->