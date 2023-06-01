---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_connections"
description: |-
  Retrieve information about connections.
---

# Data Source: aws_networkmanager_connections

Retrieve information about connections.

## Example Usage

```terraform
data "aws_networkmanager_connections" "example" {
  global_network_id = var.global_network_id

  tags = {
    Env = "test"
  }
}
```

## Argument Reference

* `deviceId` - (Optional) ID of the device of the connections to retrieve.
* `globalNetworkId` - (Required) ID of the Global Network of the connections to retrieve.
* `tags` - (Optional) Restricts the list to the connections with these tags.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `ids` - IDs of the connections.

<!-- cache-key: cdktf-0.17.0-pre.15 input-e5994d250a3d35483ae3cdedb967b6c8903cdd274b5396c06eec1983e7be88e9 -->