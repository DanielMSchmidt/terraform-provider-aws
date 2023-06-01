---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_subnet_group"
description: |-
  Provides details about a specific redshift subnet_group
---

# Data Source: aws_redshift_subnet_group

Provides details about a specific redshift subnet group.

## Example Usage

```terraform
data "aws_redshift_subnet_group" "example" {
  name = aws_redshift_subnet_group.example.name
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the cluster subnet group for which information is requested.

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Redshift Subnet Group name.
* `description` - Description of the Redshift Subnet group.
* `id` - Redshift Subnet group Name.
* `subnetIds` - An array of VPC subnet IDs.
* `tags` - Tags associated to the Subnet Group

<!-- cache-key: cdktf-0.17.0-pre.15 input-92c067305d8b94e6169f03966a05c656c227af42228823af7ab49fd8eb54eafd -->