---
subcategory: "OpsWorks"
layout: "aws"
page_title: "AWS: aws_opsworks_user_profile"
description: |-
  Provides an OpsWorks User Profile resource.
---

# Resource: aws_opsworks_user_profile

Provides an OpsWorks User Profile resource.

## Example Usage

```terraform
resource "aws_opsworks_user_profile" "my_profile" {
  user_arn     = aws_iam_user.user.arn
  ssh_username = "my_user"
}
```

## Argument Reference

The following arguments are supported:

* `userArn` - (Required) The user's IAM ARN
* `allowSelfManagement` - (Optional) Whether users can specify their own SSH public key through the My Settings page
* `sshUsername` - (Required) The ssh username, with witch this user wants to log in
* `sshPublicKey` - (Optional) The users public key

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Same value as `userArn`

<!-- cache-key: cdktf-0.17.0-pre.15 input-e73b2a441f4826b981bff52754984b747326702cbc6a20a3a376e393f196956b -->