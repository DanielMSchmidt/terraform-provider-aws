---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_connection"
description: |-
  Retrieve information about a connection.
---

# Data Source:  aws_networkmanager_connection

Retrieve information about a connection.

## Example Usage

```terraform
data "aws_networkmanager_connection" "example" {
  global_network_id = var.global_network_id
  connection_id     = var.connection_id
}
```

## Argument Reference

* `globalNetworkId` - (Required) ID of the Global Network of the connection to retrieve.
* `connectionId` - (Required) ID of the specific connection to retrieve.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the connection.
* `connectedDeviceId` - ID of the second device in the connection.
* `connectedLinkId` - ID of the link for the second device.
* `description` - Description of the connection.
* `deviceId` - ID of the first device in the connection.
* `linkId` - ID of the link for the first device.
* `tags` - Key-value tags for the connection.

<!-- cache-key: cdktf-0.17.0-pre.15 input-bb70369b4078c8fb9f1e97800478cc5d30980797600c04dfa760e96b7f77b164 -->