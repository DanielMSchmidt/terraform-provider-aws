---
subcategory: "Managed Streaming for Kafka"
layout: "aws"
page_title: "AWS: aws_msk_broker_nodes"
description: |-
  Get information on an Amazon MSK Broker Nodes
---

# Data Source: aws_msk_broker_nodes

Get information on an Amazon MSK Broker Nodes.

## Example Usage

```terraform
data "aws_msk_broker_nodes" "example" {
  cluster_arn = aws_msk_cluster.example.arn
}
```

## Argument Reference

The following arguments are supported:

* `clusterArn` - (Required) ARN of the cluster the nodes belong to.

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* [`nodeInfoList`](#nodes) - List of MSK Broker Nodes, sorted by broker ID in ascending order.

### Nodes

* `attachedEniId` - Attached elastic network interface of the broker
* `brokerId` - ID of the broker
* `clientSubnet` - Client subnet to which this broker node belongs
* `clientVpcIpAddress` - The client virtual private cloud (VPC) IP address
* `endpoints` - Set of endpoints for accessing the broker. This does not include ports
* `nodeArn` - ARN of the node

<!-- cache-key: cdktf-0.17.0-pre.15 input-d46dc5863b8b603411b3d1e51c6099c205a807f4313e861c2c891926bd364a86 -->