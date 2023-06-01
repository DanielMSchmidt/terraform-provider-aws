---
subcategory: "VPC (Virtual Private Cloud)"
layout: "aws"
page_title: "AWS: aws_main_route_table_association"
description: |-
  Provides a resource for managing the main routing table of a VPC.
---

# Resource: aws_main_route_table_association

Provides a resource for managing the main routing table of a VPC.

~> **NOTE:** **Do not** use both `awsDefaultRouteTable` to manage a default route table **and** `awsMainRouteTableAssociation` with the same VPC due to possible route conflicts. See [aws_default_route_table][tf-default-route-table] documentation for more details.
For more information, see the Amazon VPC User Guide on [Route Tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html). For information about managing normal route tables in Terraform, see [`awsRouteTable`](/docs/providers/aws/r/route_table.html).

## Example Usage

```terraform
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.foo.id
  route_table_id = aws_route_table.bar.id
}
```

## Argument Reference

The following arguments are supported:

* `vpcId` - (Required) The ID of the VPC whose main route table should be set
* `routeTableId` - (Required) The ID of the Route Table to set as the new
  main route table for the target VPC

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the Route Table Association
* `originalRouteTableId` - Used internally, see __Notes__ below

## Notes

On VPC creation, the AWS API always creates an initial Main Route Table. This
resource records the ID of that Route Table under `originalRouteTableId`.
The "Delete" action for a `mainRouteTableAssociation` consists of resetting
this original table as the Main Route Table for the VPC. You'll see this
additional Route Table in the AWS console; it must remain intact in order for
the `mainRouteTableAssociation` delete to work properly.

[aws-route-tables]: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html#Route_Replacing_Main_Table
[tf-route-tables]: /docs/providers/aws/r/route_table.html
[tf-default-route-table]: /docs/providers/aws/r/default_route_table.html

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `5M`)
- `update` - (Default `2M`)
- `delete` - (Default `5M`)

<!-- cache-key: cdktf-0.17.0-pre.15 input-eaaa49d4b9356ac8fba248c9622c4bd310a73e0bc53bf6dd1461a47402558d90 -->