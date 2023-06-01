---
subcategory: "Directory Service"
layout: "aws"
page_title: "AWS: aws_directory_service_conditional_forwarder"
description: |-
  Provides a conditional forwarder for managed Microsoft AD in AWS Directory Service.
---

# Resource: aws_directory_service_conditional_forwarder

Provides a conditional forwarder for managed Microsoft AD in AWS Directory Service.

## Example Usage

```terraform
resource "aws_directory_service_conditional_forwarder" "example" {
  directory_id       = aws_directory_service_directory.ad.id
  remote_domain_name = "example.com"

  dns_ips = [
    "8.8.8.8",
    "8.8.4.4",
  ]
}
```

## Argument Reference

The following arguments are supported:

* `directoryId` - (Required) ID of directory.
* `dnsIps` - (Required) A list of forwarder IP addresses.
* `remoteDomainName` - (Required) The fully qualified domain name of the remote domain for which forwarders will be used.

## Attributes Reference

No additional attributes are exported.

## Import

Conditional forwarders can be imported using the directory id and remote_domain_name, e.g.,

```
$ terraform import aws_directory_service_conditional_forwarder.example d-1234567890:example.com
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-dc9c94bfe73dde8e8dfe0a1dcd6a27909c62f47528d20cbf227b4aac33fd9dd7 -->