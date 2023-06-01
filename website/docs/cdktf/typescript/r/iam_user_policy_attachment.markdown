---
subcategory: "IAM (Identity & Access Management)"
layout: "aws"
page_title: "AWS: aws_iam_user_policy_attachment"
description: |-
  Attaches a Managed IAM Policy to an IAM user
---

# Resource: aws_iam_user_policy_attachment

Attaches a Managed IAM Policy to an IAM user

~> **NOTE:** The usage of this resource conflicts with the `awsIamPolicyAttachment` resource and will permanently show a difference if both are defined.

## Example Usage

```terraform
resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "{ ... policy JSON ... }"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
```

## Argument Reference

The following arguments are supported:

* `user`        (Required) - The user the policy should be applied to
* `policyArn`  (Required) - The ARN of the policy you want to apply

## Attributes Reference

No additional attributes are exported.

## Import

IAM user policy attachments can be imported using the user name and policy arn separated by `/`.

```
$ terraform import aws_iam_user_policy_attachment.test-attach test-user/arn:aws:iam::xxxxxxxxxxxx:policy/test-policy
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-9a7832c1d726699b55aefa7ae6ee59699bffb95699e99283e9e826312a98fc62 -->