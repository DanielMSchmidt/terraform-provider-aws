---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_network_interface_attachment"
description: |-
  Attach an Elastic network interface (ENI) resource with EC2 instance.
---

# Resource: aws_network_interface_attachment

Attach an Elastic network interface (ENI) resource with EC2 instance.

## Example Usage

```terraform
resource "aws_network_interface_attachment" "test" {
  instance_id          = aws_instance.test.id
  network_interface_id = aws_network_interface.test.id
  device_index         = 0
}
```

## Argument Reference

The following arguments are supported:

* `instanceId` - (Required) Instance ID to attach.
* `networkInterfaceId` - (Required) ENI ID to attach.
* `deviceIndex` - (Required) Network interface index (int).

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `instanceId` - Instance ID.
* `networkInterfaceId` - Network interface ID.
* `attachmentId` - The ENI Attachment ID.
* `status` - The status of the Network Interface Attachment.

## Import

Elastic network interface (ENI) Attachments can be imported using its Attachment ID e.g.,

```
terraform import aws_network_interface_attachment.secondary_nic eni-attach-0a33842b4ec347c4c
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-45c19291392a9eafa3259cfde90a97caeb346a25e5d068875a2ddb309db7af11 -->