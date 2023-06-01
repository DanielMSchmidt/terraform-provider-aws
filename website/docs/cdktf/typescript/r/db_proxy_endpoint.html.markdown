---
subcategory: "RDS (Relational Database)"
layout: "aws"
page_title: "AWS: aws_db_proxy_endpoint"
description: |-
  Provides an RDS DB proxy endpoint resource.
---

# Resource: aws_db_proxy_endpoint

Provides an RDS DB proxy endpoint resource. For additional information, see the [RDS User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-proxy-endpoints.html).

## Example Usage

```terraform
resource "aws_db_proxy_endpoint" "example" {
  db_proxy_name          = aws_db_proxy.test.name
  db_proxy_endpoint_name = "example"
  vpc_subnet_ids         = aws_subnet.test[*].id
  target_role            = "READ_ONLY"
}
```

## Argument Reference

The following arguments are supported:

* `dbProxyEndpointName` - (Required) The identifier for the proxy endpoint. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens.
* `dbProxyName` - (Required) The name of the DB proxy associated with the DB proxy endpoint that you create.
* `vpcSubnetIds` - (Required) One or more VPC subnet IDs to associate with the new proxy.
* `vpcSecurityGroupIds` - (Optional) One or more VPC security group IDs to associate with the new proxy.
* `targetRole` - (Optional) Indicates whether the DB proxy endpoint can be used for read/write or read-only operations. The default is `readWrite`. Valid values are `readWrite` and `readOnly`.
* `tags` - (Optional) A mapping of tags to assign to the resource.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The name of the proxy and proxy endpoint separated by `/`, `dbProxyName/dbProxyEndpointName`.
* `arn` - The Amazon Resource Name (ARN) for the proxy endpoint.
* `endpoint` - The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application.
* `isDefault` - Indicates whether this endpoint is the default endpoint for the associated DB proxy.
* `vpcId` - The VPC ID of the DB proxy endpoint.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `30M`)
- `update` - (Default `30M`)
- `delete` - (Default `60M`)

## Import

DB proxy endpoints can be imported using the `dbProxyName/dbProxyEndpointName`, e.g.,

```
$ terraform import aws_db_proxy_endpoint.example example/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-4e859019a56c72441f5f2f071a2a2c870932602b4413c005ee3582474ddebfba -->