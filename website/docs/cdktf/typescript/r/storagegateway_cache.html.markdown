---
subcategory: "Storage Gateway"
layout: "aws"
page_title: "AWS: aws_storagegateway_cache"
description: |-
  Manages an AWS Storage Gateway cache
---

# Resource: aws_storagegateway_cache

Manages an AWS Storage Gateway cache.

~> **NOTE:** The Storage Gateway API provides no method to remove a cache disk. Destroying this Terraform resource does not perform any Storage Gateway actions.

## Example Usage

```terraform
resource "aws_storagegateway_cache" "example" {
  disk_id     = data.aws_storagegateway_local_disk.example.id
  gateway_arn = aws_storagegateway_gateway.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `diskId` - (Required) Local disk identifier. For example, `pci0000:03:000Scsi0:0:0:0`.
* `gatewayArn` - (Required) The Amazon Resource Name (ARN) of the gateway.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Combined gateway Amazon Resource Name (ARN) and local disk identifier.

## Import

`awsStoragegatewayCache` can be imported by using the gateway Amazon Resource Name (ARN) and local disk identifier separated with a colon (`:`), e.g.,

```
$ terraform import aws_storagegateway_cache.example arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678:pci-0000:03:00.0-scsi-0:0:0:0
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-bca7c136f39f1a7de2e0b47be4d90ecf684d8ae43f04e65e56a78ebb497b8c85 -->