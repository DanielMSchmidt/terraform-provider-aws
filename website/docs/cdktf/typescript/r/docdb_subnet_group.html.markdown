---
subcategory: "DocumentDB"
layout: "aws"
page_title: "AWS: aws_docdb_subnet_group"
description: |-
  Provides an DocumentDB subnet group resource.
---

# Resource: aws_docdb_subnet_group

Provides an DocumentDB subnet group resource.

## Example Usage

```terraform
resource "aws_docdb_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

  tags = {
    Name = "My docdb subnet group"
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Optional, Forces new resource) The name of the docDB subnet group. If omitted, Terraform will assign a random, unique name.
* `namePrefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with `name`.
* `description` - (Optional) The description of the docDB subnet group. Defaults to "Managed by Terraform".
* `subnetIds` - (Required) A list of VPC subnet IDs.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The docDB subnet group name.
* `arn` - The ARN of the docDB subnet group.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

DocumentDB Subnet groups can be imported using the `name`, e.g.,

```
$ terraform import aws_docdb_subnet_group.default production-subnet-group
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-575b6c31494133a26ca95f1900e249be3841d9c4fc1acf436ab72ef1e5fa5835 -->