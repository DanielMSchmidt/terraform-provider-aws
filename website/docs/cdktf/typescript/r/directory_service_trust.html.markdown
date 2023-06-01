---
subcategory: "Directory Service"
layout: "aws"
page_title: "AWS: aws_directory_service_trust"
description: |-
  Manages a trust relationship between two Active Directory Directories.
---

# Resource: aws_directory_service_trust

Manages a trust relationship between two Active Directory Directories.

The directories may either be both AWS Managed Microsoft AD domains or an AWS Managed Microsoft AD domain and a self-managed Active Directory Domain.

The Trust relationship must be configured on both sides of the relationship.
If a Trust has only been created on one side, it will be in the state `verifyFailed`.
Once the second Trust is created, the first will update to the correct state.

## Example Usage

### Two-Way Trust

```terraform
resource "aws_directory_service_trust" "one" {
  directory_id = aws_directory_service_directory.one.id

  remote_domain_name = aws_directory_service_directory.two.name
  trust_direction    = "Two-Way"
  trust_password     = "Some0therPassword"

  conditional_forwarder_ip_addrs = aws_directory_service_directory.two.dns_ip_addresses
}

resource "aws_directory_service_trust" "two" {
  directory_id = aws_directory_service_directory.two.id

  remote_domain_name = aws_directory_service_directory.one.name
  trust_direction    = "Two-Way"
  trust_password     = "Some0therPassword"

  conditional_forwarder_ip_addrs = aws_directory_service_directory.one.dns_ip_addresses
}

resource "aws_directory_service_directory" "one" {
  name = "one.example.com"
  type = "MicrosoftAD"
  # ...
}

resource "aws_directory_service_directory" "two" {
  name = "two.example.com"
  type = "MicrosoftAD"
  # ...
}
```

### One-Way Trust

```terraform
resource "aws_directory_service_trust" "one" {
  directory_id = aws_directory_service_directory.one.id

  remote_domain_name = aws_directory_service_directory.two.name
  trust_direction    = "One-Way: Incoming"
  trust_password     = "Some0therPassword"

  conditional_forwarder_ip_addrs = aws_directory_service_directory.two.dns_ip_addresses
}

resource "aws_directory_service_trust" "two" {
  directory_id = aws_directory_service_directory.two.id

  remote_domain_name = aws_directory_service_directory.one.name
  trust_direction    = "One-Way: Outgoing"
  trust_password     = "Some0therPassword"

  conditional_forwarder_ip_addrs = aws_directory_service_directory.one.dns_ip_addresses
}

resource "aws_directory_service_directory" "one" {
  name = "one.example.com"
  type = "MicrosoftAD"
  # ...
}

resource "aws_directory_service_directory" "two" {
  name = "two.example.com"
  type = "MicrosoftAD"
  # ...
}
```

## Argument Reference

The following arguments are supported:

* `conditionalForwarderIpAddrs` - (Optional) Set of IPv4 addresses for the DNS server associated with the remote Directory.
  Can contain between 1 and 4 values.
* `deleteAssociatedConditionalForwarder` - (Optional) Whether to delete the conditional forwarder when deleting the Trust relationship.
* `directoryId` - (Required) ID of the Directory.
* `remoteDomainName` - (Required) Fully qualified domain name of the remote Directory.
* `selectiveAuth` - (Optional) Whether to enable selective authentication.
  Valid values are `enabled` and `disabled`.
  Default value is `disabled`.
* `trustDirection` - (Required) The direction of the Trust relationship.
  Valid values are `One-Way: Outgoing`, `One-Way: Incoming`, and `twoWay`.
* `trustPassword` - (Required) Password for the Trust.
  Does not need to match the passwords for either Directory.
  Can contain upper- and lower-case letters, numbers, and punctuation characters.
  May be up to 128 characters long.
* `trustType` - (Optional) Type of the Trust relationship.
  Valid values are `forest` and `external`.
  Default value is `forest`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `createdDateTime` - Date and time when the Trust was created.
* `id` - The Trust identifier.
* `lastUpdatedDateTime` - Date and time when the Trust was last updated.
* `stateLastUpdatedDateTime` - Date and time when the Trust state in `trustState` was last updated.
* `trustState` - State of the Trust relationship.
  One of `created`, `verifyFailed`,`verified`, `updateFailed`,`updated`,`deleted`, or `failed`.
* `trustStateReason` - Reason for the Trust state set in `trustState`.

## Import

The Trust relationsiop can be imported using the directory ID and remote domain name, separated by a `/`, e.g.,

```
$ terraform import aws_directory_service_trust.example d-926724cf57/directory.example.com
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-89d2cb0d2b1443f11467d5569acb0dacac12695348b7b5439ad284bcd84770e6 -->