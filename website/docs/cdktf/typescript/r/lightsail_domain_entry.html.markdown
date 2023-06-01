---
subcategory: "Lightsail"
layout: "aws"
page_title: "AWS: aws_lightsail_domain_entry"
description: |-
  Provides an Lightsail Domain Entry
---

# Resource: aws_lightsail_domain_entry

Creates a domain entry resource

~> **NOTE on `id`:** In an effort to simplify imports, this resource `id` field has been updated to the standard resource id separator, a comma (`,`). For backward compatibility, the previous separator (underscore `_`) can still be used to read and import existing resources. When state is refreshed, the `id` will be updated to use the new standard separator. The previous separator will be deprecated in a future major release.

## Example Usage

```terraform
resource "aws_lightsail_domain" "test" {
  domain_name = "mydomain.com"
}

resource "aws_lightsail_domain_entry" "test" {
  domain_name = aws_lightsail_domain.domain_test.domain_name
  name        = "www"
  type        = "A"
  target      = "127.0.0.1"
}

```

## Argument Reference

The following arguments are supported:

* `domainName` - (Required) The name of the Lightsail domain in which to create the entry
* `name` - (Required) Name of the entry record
* `type` - (Required) Type of record
* `target` - (Required) Target of the domain entry
* `isAlias` - (Optional) If the entry should be an alias Defaults to `false`

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - A combination of attributes to create a unique id: `name`,`domainName`,`type`,`target`

## Import

`awsLightsailDomainEntry` can be imported by using the id attribute, e.g.,

```
$ terraform import aws_lightsail_domain_entry.example www,mydomain.com,A,127.0.0.1
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-d734f8f2b1382e8a2e725d938487f830bf26d3653174b9df7f6b94831237f5ab -->