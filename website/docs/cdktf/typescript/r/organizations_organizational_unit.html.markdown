---
subcategory: "Organizations"
layout: "aws"
page_title: "AWS: aws_organizations_organizational_unit"
description: |-
  Provides a resource to create an organizational unit.
---

# Resource: aws_organizations_organizational_unit

Provides a resource to create an organizational unit.

## Example Usage

```terraform
resource "aws_organizations_organizational_unit" "example" {
  name      = "example"
  parent_id = aws_organizations_organization.example.roots[0].id
}
```

## Argument Reference

The following arguments are supported:

* `name` - The name for the organizational unit
* `parentId` - ID of the parent organizational unit, which may be the root
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `accounts` - List of child accounts for this Organizational Unit. Does not return account information for child Organizational Units. All elements have these attributes:
    * `arn` - ARN of the account
    * `email` - Email of the account
    * `id` - Identifier of the account
    * `name` - Name of the account
* `arn` - ARN of the organizational unit
* `id` - Identifier of the organization unit
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

AWS Organizations Organizational Units can be imported by using the `id`, e.g.,

```
$ terraform import aws_organizations_organizational_unit.example ou-1234567
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-466ecb8c88de0913942b81ec73fb7c4e14ce97cc3d8d0c5de2fa994c942715cf -->