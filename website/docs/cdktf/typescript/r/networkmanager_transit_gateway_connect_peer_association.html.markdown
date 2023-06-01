---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_transit_gateway_connect_peer_association"
description: |-
  Associates a transit gateway Connect peer with a device, and optionally, with a link.
---

# Resource: aws_networkmanager_transit_gateway_connect_peer_association

Associates a transit gateway Connect peer with a device, and optionally, with a link.
If you specify a link, it must be associated with the specified device.

## Example Usage

```terraform
resource "aws_networkmanager_transit_gateway_connect_peer_association" "example" {
  global_network_id                = aws_networkmanager_global_network.example.id
  device_id                        = aws_networkmanager_device.example.id
  transit_gateway_connect_peer_arn = aws_ec2_transit_gateway_connect_peer.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `deviceId` - (Required) The ID of the device.
* `globalNetworkId` - (Required) The ID of the global network.
* `linkId` - (Optional) The ID of the link.
* `transitGatewayConnectPeerArn` - (Required) The Amazon Resource Name (ARN) of the Connect peer.

## Attributes Reference

No additional attributes are exported.

## Import

`awsNetworkmanagerTransitGatewayConnectPeerAssociation` can be imported using the global network ID and customer gateway ARN, e.g.

```
$ terraform import aws_networkmanager_transit_gateway_connect_peer_association.example global-network-0d47f6t230mz46dy4,arn:aws:ec2:us-west-2:123456789012:transit-gateway-connect-peer/tgw-connect-peer-12345678
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c2c7f93d27c94089efa42ac1cd8106c51d97a8c6a9345721d2644b5a0faccaf2 -->