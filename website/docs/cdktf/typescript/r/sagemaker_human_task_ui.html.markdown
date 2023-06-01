---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_human_task_ui"
description: |-
  Provides a SageMaker Human Task UI resource.
---

# Resource: aws_sagemaker_human_task_ui

Provides a SageMaker Human Task UI resource.

## Example Usage

```terraform
resource "aws_sagemaker_human_task_ui" "example" {
  human_task_ui_name = "example"

  ui_template {
    content = file("sagemaker-human-task-ui-template.html")
  }
}
```

## Argument Reference

The following arguments are supported:

* `humanTaskUiName` - (Required) The name of the Human Task UI.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `uiTemplate` - (Required) The Liquid template for the worker user interface. See [UI Template](#ui-template) below.

### UI Template

* `content` - (Required) The content of the Liquid template for the worker user interface.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Human Task UI.
* `id` - The name of the Human Task UI.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `uiTemplate` - (Required) The Liquid template for the worker user interface. See [UI Template](#ui-template) below.

### UI Template

* `contentSha256` - The SHA-256 digest of the contents of the template.
* `url` - The URL for the user interface template.

## Import

SageMaker Human Task UIs can be imported using the `humanTaskUiName`, e.g.,

```
$ terraform import aws_sagemaker_human_task_ui.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-14e2ceead888a10baec9b8d870be049b1af3b58866e5f92edc7ffd3ff2c8f1bb -->