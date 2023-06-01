---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_device"
description: |-
  Retrieve information about a device.
---

# Data Source: aws_networkmanager_device

Retrieve information about a device.

## Example Usage

```terraform
data "aws_networkmanager_device" "example" {
  global_network_id_id = var.global_network_id
  device_id            = var.device_id
}
```

## Argument Reference

* `deviceId` - (Required) ID of the device.
* `globalNetworkId` - (Required) ID of the global network.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the device.
* `awsLocation` - AWS location of the device. Documented below.
* `description` - Description of the device.
* `location` - Location of the device. Documented below.
* `model` - Model of device.
* `serialNumber` - Serial number of the device.
* `siteId` - ID of the site.
* `tags` - Key-value tags for the device.
* `type` - Type of device.
* `vendor` - Vendor of the device.

The `awsLocation` object supports the following:

* `subnetArn` - ARN of the subnet that the device is located in.
* `zone` - Zone that the device is located in.

The `location` object supports the following:

* `address` - Physical address.
* `latitude` - Latitude.
* `longitude` - Longitude.

<!-- cache-key: cdktf-0.17.0-pre.15 input-3c2fb69bcea2cd85f0128aded94623d09c9a4fe041d966fb8bb50ad10cf8ecdf -->