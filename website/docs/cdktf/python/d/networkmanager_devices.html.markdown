---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_devices"
description: |-
  Retrieve information about devices.
---

# Data Source: aws_networkmanager_devices

Retrieve information about devices.

## Example Usage

```terraform
data "aws_networkmanager_devices" "example" {
  global_network_id = var.global_network_id

  tags = {
    Env = "test"
  }
}
```

## Argument Reference

* `global_network_id` - (Required) ID of the Global Network of the devices to retrieve.
* `site_id` - (Optional) ID of the site of the devices to retrieve.
* `tags` - (Optional) Restricts the list to the devices with these tags.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `ids` - IDs of the devices.

<!-- cache-key: cdktf-0.17.0-pre.15 input-f68a3add18f8c1361bae59487aaaa5ed50f89a648f8e43eb2b78041aba3bfda3 -->