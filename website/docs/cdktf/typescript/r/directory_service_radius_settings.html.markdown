---
subcategory: "Directory Service"
layout: "aws"
page_title: "AWS: aws_directory_service_radius_settings"
description: |-
  Manages a directory's multi-factor authentication (MFA) using a Remote Authentication Dial In User Service (RADIUS) server.
---

# Resource: aws_directory_service_radius_settings

Manages a directory's multi-factor authentication (MFA) using a Remote Authentication Dial In User Service (RADIUS) server.

## Example Usage

```terraform
resource "aws_directory_service_radius_settings" "example" {
  directory_id = aws_directory_service_directory.example.id

  authentication_protocol = "PAP"
  display_label           = "example"
  radius_port             = 1812
  radius_retries          = 4
  radius_servers          = ["10.0.1.5"]
  radius_timeout          = 1
  shared_secret           = "12345678"
}
```

## Argument Reference

The following arguments are supported:

* `authenticationProtocol` - (Optional) The protocol specified for your RADIUS endpoints. Valid values: `pap`, `chap`, `msChaPv1`, `msChaPv2`.
* `directoryId` - (Required) The identifier of the directory for which you want to manager RADIUS settings.
* `displayLabel` - (Required) Display label.
* `radiusPort` - (Required) The port that your RADIUS server is using for communications. Your self-managed network must allow inbound traffic over this port from the AWS Directory Service servers.
* `radiusRetries` - (Required) The maximum number of times that communication with the RADIUS server is attempted. Minimum value of `0`. Maximum value of `10`.
* `radiusServers` - (Required) An array of strings that contains the fully qualified domain name (FQDN) or IP addresses of the RADIUS server endpoints, or the FQDN or IP addresses of your RADIUS server load balancer.
* `radiusTimeout` - (Required) The amount of time, in seconds, to wait for the RADIUS server to respond. Minimum value of `1`. Maximum value of `50`.
* `sharedSecret` - (Required) Required for enabling RADIUS on the directory.
* `useSameUsername` - (Optional) Not currently used.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The directory identifier.

## Timeouts

`awsDirectoryServiceRadiusSettings` provides the following [Timeouts](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts) configuration options:

- `create` - (Default `30 minutes`) Used for RADIUS settings creation
- `update` - (Default `30 minutes`) Used for RADIUS settings update

## Import

RADIUS settings can be imported using the directory ID, e.g.,

```
$ terraform import aws_directory_service_radius_settings.example d-926724cf57
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-8835254fb93dd008f69950b11c08c3bbf604d84fc14ae5982008d7d91b681116 -->