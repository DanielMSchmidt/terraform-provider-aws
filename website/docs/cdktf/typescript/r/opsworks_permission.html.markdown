---
subcategory: "OpsWorks"
layout: "aws"
page_title: "AWS: aws_opsworks_permission"
description: |-
  Provides an OpsWorks permission resource.
---

# Resource: aws_opsworks_permission

Provides an OpsWorks permission resource.

## Example Usage

```terraform
resource "aws_opsworks_permission" "my_stack_permission" {
  allow_ssh  = true
  allow_sudo = true
  level      = "iam_only"
  user_arn   = aws_iam_user.user.arn
  stack_id   = aws_opsworks_stack.stack.id
}
```

## Argument Reference

The following arguments are supported:

* `allowSsh` - (Optional) Whether the user is allowed to use SSH to communicate with the instance
* `allowSudo` - (Optional) Whether the user is allowed to use sudo to elevate privileges
* `userArn` - (Required) The user's IAM ARN to set permissions for
* `level` - (Optional) The users permission level. Mus be one of `deny`, `show`, `deploy`, `manage`, `iamOnly`
* `stackId` - (Required) The stack to set the permissions for

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The computed id of the permission. Please note that this is only used internally to identify the permission. This value is not used in aws.

<!-- cache-key: cdktf-0.17.0-pre.15 input-6dbed47692a6d9b99d211e21e5d54dbc0c53fb718b44a081ab96a76b6d310765 -->