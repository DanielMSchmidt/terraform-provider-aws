---
subcategory: "Security Hub"
layout: "aws"
page_title: "AWS: aws_securityhub_invite_accepter"
description: |-
  Accepts a Security Hub invitation.
---

# Resource: aws_securityhub_invite_accepter

-> **Note:** AWS accounts can only be associated with a single Security Hub master account. Destroying this resource will disassociate the member account from the master account.

Accepts a Security Hub invitation.

## Example Usage

```terraform
resource "aws_securityhub_account" "example" {}

resource "aws_securityhub_member" "example" {
  account_id = "123456789012"
  email      = "example@example.com"
  invite     = true
}

resource "aws_securityhub_account" "invitee" {
  provider = "aws.invitee"
}

resource "aws_securityhub_invite_accepter" "invitee" {
  provider   = "aws.invitee"
  depends_on = [aws_securityhub_account.invitee]
  master_id  = aws_securityhub_member.example.master_id
}
```

## Argument Reference

The following arguments are supported:

* `masterId` - (Required) The account ID of the master Security Hub account whose invitation you're accepting.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `invitationId` - The ID of the invitation.

## Import

Security Hub invite acceptance can be imported using the account ID, e.g.,

```
$ terraform import aws_securityhub_invite_accepter.example 123456789012
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-231ee377cba19cb2fcbcb298d878cbdd096b05cc6e9bd333985b64e69a23e6fb -->