---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_device"
description: |-
  Provides a SageMaker Device resource.
---

# Resource: aws_sagemaker_device

Provides a SageMaker Device resource.

## Example Usage

### Basic usage

```terraform
resource "aws_sagemaker_device" "example" {
  device_fleet_name = aws_sagemaker_device_fleet.example.device_fleet_name

  device {
    device_name = "example"
  }
}
```

## Argument Reference

The following arguments are supported:

* `deviceFleetName` - (Required) The name of the Device Fleet.
* `device` - (Required) The device to register with SageMaker Edge Manager. See [Device](#device) details below.

### Device

* `description` - (Required) A description for the device.
* `deviceName` - (Optional) The name of the device.
* `iotThingName` - (Optional) Amazon Web Services Internet of Things (IoT) object name.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The id is constructed from `deviceFleetName/deviceName`.
* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Device.

## Import

SageMaker Devices can be imported using the `deviceFleetName/deviceName`, e.g.,

```
$ terraform import aws_sagemaker_device.example my-fleet/my-device
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-491ec0a2fa98920f6a6ac28ff50eb02e8a6cb2be06d2431b28cf17dd5a1402e0 -->