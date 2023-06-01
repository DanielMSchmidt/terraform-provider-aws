---
subcategory: "OpsWorks"
layout: "aws"
page_title: "AWS: aws_opsworks_rds_db_instance"
description: |-
  Provides an OpsWorks RDS DB Instance resource.
---

# Resource: aws_opsworks_rds_db_instance

Provides an OpsWorks RDS DB Instance resource.

~> **Note:** All arguments including the username and password will be stored in the raw state as plain-text.
[Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

## Example Usage

```terraform
resource "aws_opsworks_rds_db_instance" "my_instance" {
  stack_id            = aws_opsworks_stack.my_stack.id
  rds_db_instance_arn = aws_db_instance.my_instance.arn
  db_user             = "someUser"
  db_password         = "somePass"
}
```

## Argument Reference

The following arguments are supported:

* `stackId` - (Required) The stack to register a db instance for. Changing this will force a new resource.
* `rdsDbInstanceArn` - (Required) The db instance to register for this stack. Changing this will force a new resource.
* `dbUser` - (Required) A db username
* `dbPassword` - (Required) A db password

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The computed id. Please note that this is only used internally to identify the stack <-> instance relation. This value is not used in aws.

<!-- cache-key: cdktf-0.17.0-pre.15 input-dc78af11c4f80cca4441a524eef5fa900cf8d66a0c5a02337e6fb1e3919caf01 -->