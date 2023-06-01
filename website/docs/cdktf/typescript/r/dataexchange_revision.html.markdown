---
subcategory: "Data Exchange"
layout: "aws"
page_title: "AWS: aws_dataexchange_revision"
description: |-
  Provides a DataExchange Revision
---

# Resource: aws_dataexchange_revision

Provides a resource to manage AWS Data Exchange Revisions.

## Example Usage

```terraform
resource "aws_dataexchange_revision" "example" {
  data_set_id = aws_dataexchange_data_set.example.id
}
```

## Argument Reference

* `dataSetId` - (Required) The dataset id.
* `comment` - (Required) An optional comment about the revision.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Id of the data set.
* `revisionId` - The Id of the revision.
* `arn` - The Amazon Resource Name of this data set.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

DataExchange Revisions can be imported by their `dataSetId:revisionId`:

```
$ terraform import aws_dataexchange_revision.example 4fa784c7-ccb4-4dbf-ba4f-02198320daa1:4fa784c7-ccb4-4dbf-ba4f-02198320daa1
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-89fd92c79359def8f843d6a45f3a92f07a9810778dfb01828549326e29df8e43 -->