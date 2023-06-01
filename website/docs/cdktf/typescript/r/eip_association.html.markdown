---
subcategory: "EC2 (Elastic Compute Cloud)"
layout: "aws"
page_title: "AWS: aws_eip_association"
description: |-
  Provides an AWS EIP Association
---

# Resource: aws_eip_association

Provides an AWS EIP Association as a top level resource, to associate and
disassociate Elastic IPs from AWS Instances and Network Interfaces.

~> **NOTE:** Do not use this resource to associate an EIP to `awsLb` or `awsNatGateway` resources. Instead use the `allocationId` available in those resources to allow AWS to manage the association, otherwise you will see `authFailure` errors.

~> **NOTE:** `awsEipAssociation` is useful in scenarios where EIPs are either
pre-existing or distributed to customers or users and therefore cannot be changed.

## Example Usage

```terraform
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.example.id
}

resource "aws_instance" "web" {
  ami               = "ami-21f78e11"
  availability_zone = "us-west-2a"
  instance_type     = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_eip" "example" {
  domain = "vpc"
}
```

## Argument Reference

The following arguments are supported:

* `allocationId` - (Optional) The allocation ID. This is required for EC2-VPC.
* `allowReassociation` - (Optional, Boolean) Whether to allow an Elastic IP to
be re-associated. Defaults to `true` in VPC.
* `instanceId` - (Optional) The ID of the instance. This is required for
EC2-Classic. For EC2-VPC, you can specify either the instance ID or the
network interface ID, but not both. The operation fails if you specify an
instance ID unless exactly one network interface is attached.
* `networkInterfaceId` - (Optional) The ID of the network interface. If the
instance has more than one network interface, you must specify a network
interface ID.
* `privateIpAddress` - (Optional) The primary or secondary private IP address
to associate with the Elastic IP address. If no private IP address is
specified, the Elastic IP address is associated with the primary private IP
address.
* `publicIp` - (Optional) The Elastic IP address. This is required for EC2-Classic.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `associationId` - The ID that represents the association of the Elastic IP
address with an instance.
* `allocationId` - As above
* `instanceId` - As above
* `networkInterfaceId` - As above
* `privateIpAddress` - As above
* `publicIp` - As above

## Import

EIP Assocations can be imported using their association ID.

```
$ terraform import aws_eip_association.test eipassoc-ab12c345
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-e328a42eac021a3d758783a88e8352a34ef10a0d81ac2e5add56db0ad6386fad -->