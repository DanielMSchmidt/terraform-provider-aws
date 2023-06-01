---
subcategory: "EC2 (Elastic Compute Cloud)"
layout: "aws"
page_title: "AWS: aws_eip"
description: |-
  Provides an Elastic IP resource.
---

# Resource: aws_eip

Provides an Elastic IP resource.

~> **Note:** EIP may require IGW to exist prior to association. Use `dependsOn` to set an explicit dependency on the IGW.

~> **Note:** Do not use `networkInterface` to associate the EIP to `awsLb` or `awsNatGateway` resources. Instead use the `allocationId` available in those resources to allow AWS to manage the association, otherwise you will see `authFailure` errors.

## Example Usage

### Single EIP associated with an instance

```terraform
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  domain   = "vpc"
}
```

### Multiple EIPs associated with a single network interface

```terraform
resource "aws_network_interface" "multi-ip" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.0.10", "10.0.0.11"]
}

resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.10"
}

resource "aws_eip" "two" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.11"
}
```

### Attaching an EIP to an Instance with a pre-assigned private ip (VPC Only)

```terraform
resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id
}

resource "aws_subnet" "tf_test_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_instance" "foo" {
  # us-west-2
  ami           = "ami-5189a661"
  instance_type = "t2.micro"

  private_ip = "10.0.0.12"
  subnet_id  = aws_subnet.tf_test_subnet.id
}

resource "aws_eip" "bar" {
  domain = "vpc"

  instance                  = aws_instance.foo.id
  associate_with_private_ip = "10.0.0.12"
  depends_on                = [aws_internet_gateway.gw]
}
```

### Allocating EIP from the BYOIP pool

```terraform
resource "aws_eip" "byoip-ip" {
  domain           = "vpc"
  public_ipv4_pool = "ipv4pool-ec2-012345"
}
```

## Argument Reference

The following arguments are supported:

* `address` - (Optional) IP address from an EC2 BYOIP pool. This option is only available for VPC EIPs.
* `associateWithPrivateIp` - (Optional) User-specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address.
* `customerOwnedIpv4Pool` - (Optional) ID  of a customer-owned address pool. For more on customer owned IP addressed check out [Customer-owned IP addresses guide](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-networking-components.html#ip-addressing).
* `domain` - Indicates if this EIP is for use in VPC (`vpc`).
* `instance` - (Optional) EC2 instance ID.
* `networkBorderGroup` - (Optional) Location from which the IP address is advertised. Use this parameter to limit the address to this location.
* `networkInterface` - (Optional) Network interface ID to associate with.
* `publicIpv4Pool` - (Optional) EC2 IPv4 address pool identifier or `amazon`.
  This option is only available for VPC EIPs.
* `tags` - (Optional) Map of tags to assign to the resource. Tags can only be applied to EIPs in a VPC. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `vpc` - (Optional **Deprecated**) Boolean if the EIP is in a VPC or not. Use `domain` instead.
  Defaults to `true` unless the region supports EC2-Classic.

~> **NOTE:** You can specify either the `instance` ID or the `networkInterface` ID, but not both. Including both will **not** return an error from the AWS API, but will have undefined behavior. See the relevant [AssociateAddress API Call][1] for more information.

~> **NOTE:** Specifying both `publicIpv4Pool` and `address` won't cause an error but `address` will be used in the
case both options are defined as the api only requires one or the other.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `allocationId` - ID that AWS assigns to represent the allocation of the Elastic IP address for use with instances in a VPC.
* `associationId` - ID representing the association of the address with an instance in a VPC.
* `carrierIp` - Carrier IP address.
* `customerOwnedIp` - Customer owned IP.
* `id` - Contains the EIP allocation ID.
* `privateDns` - The Private DNS associated with the Elastic IP address (if in VPC).
* `privateIp` - Contains the private IP address (if in VPC).
* `publicDns` - Public DNS associated with the Elastic IP address.
* `publicIp` - Contains the public IP address.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

~> **Note:** The resource computes the `publicDns` and `privateDns` attributes according to the [VPC DNS Guide](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html#vpc-dns-hostnames) as they are not available with the EC2 API.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `read` - (Default `15M`)
- `update` - (Default `5M`)
- `delete` - (Default `3M`)

## Import

EIPs in a VPC can be imported using their Allocation ID, e.g.,

```
$ terraform import aws_eip.bar eipalloc-00a10e96
```

EIPs in EC2-Classic can be imported using their Public IP, e.g.,

```
$ terraform import aws_eip.bar 52.0.0.0
```

[1]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AssociateAddress.html

<!-- cache-key: cdktf-0.17.0-pre.15 input-dc986939790a7ba28ff5e8a0a95ad926c7ac7cfad56b25b8ecfb2f0ead235dee -->