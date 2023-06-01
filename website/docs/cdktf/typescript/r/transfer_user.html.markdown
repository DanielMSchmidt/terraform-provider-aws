---
subcategory: "Transfer Family"
layout: "aws"
page_title: "AWS: aws_transfer_user"
description: |-
  Provides a AWS Transfer User resource.
---

# Resource: aws_transfer_user

Provides a AWS Transfer User resource. Managing SSH keys can be accomplished with the [`awsTransferSshKey` resource](/docs/providers/aws/r/transfer_ssh_key.html).

## Example Usage

```terraform
resource "aws_transfer_server" "foo" {
  identity_provider_type = "SERVICE_MANAGED"

  tags = {
    NAME = "tf-acc-test-transfer-server"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "foo" {
  name               = "tf-test-transfer-user-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "foo" {
  statement {
    sid       = "AllowFullAccesstoS3"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "foo" {
  name   = "tf-test-transfer-user-iam-policy"
  role   = aws_iam_role.foo.id
  policy = data.aws_iam_role_policy.foo.json
}

resource "aws_transfer_user" "foo" {
  server_id = aws_transfer_server.foo.id
  user_name = "tftestuser"
  role      = aws_iam_role.foo.arn

  home_directory_type = "LOGICAL"
  home_directory_mappings {
    entry  = "/test.pdf"
    target = "/bucket3/test-path/tftestuser.pdf"
  }
}
```

## Argument Reference

The following arguments are supported:

* `serverId` - (Required) The Server ID of the Transfer Server (e.g., `s12345678`)
* `userName` - (Required) The name used for log in to your SFTP server.
* `homeDirectory` - (Optional) The landing directory (folder) for a user when they log in to the server using their SFTP client.  It should begin with a ``/`  The first item in the path is the name of the home bucket (accessible as `${transfer:homeBucket}` in the policy) and the rest is the home directory (accessible as `${transfer:homeDirectory}` in the policy). For example, `/exampleBucket1234/username` would set the home bucket to `exampleBucket1234` and the home directory to `username`.
* `homeDirectoryMappings` - (Optional) Logical directory mappings that specify what S3 paths and keys should be visible to your user and how you want to make them visible. See [Home Directory Mappings](#home-directory-mappings) below.
* `homeDirectoryType` - (Optional) The type of landing directory (folder) you mapped for your users' home directory. Valid values are `path` and `logical`.
* `policy` - (Optional) An IAM JSON policy document that scopes down user access to portions of their Amazon S3 bucket. IAM variables you can use inside this policy include `${transfer:userName}`, `${transfer:homeDirectory}`, and `${transfer:homeBucket}`. Since the IAM variable syntax matches Terraform's interpolation syntax, they must be escaped inside Terraform configuration strings (`${transfer:userName}`).  These are evaluated on-the-fly when navigating the bucket.
* ``posixProfile`- (Optional) Specifies the full POSIX identity, including user ID (Uid), group ID (Gid), and any secondary groups IDs (SecondaryGids), that controls your users' access to your Amazon EFS file systems. See [Posix Profile](#posix-profile) below.
* ``role`- (Required) Amazon Resource Name (ARN) of an IAM role that allows the service to controls your user’s access to your Amazon S3 bucket.
* ``tags`- (Optional) A map of tags to assign to the resource. If configured with a provider [``defaultTags`configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Home Directory Mappings

* ``entry`- (Required) Represents an entry and a target.
* ``target`- (Required) Represents the map target.

The ``restricted`option is achieved using the following mapping:

```
home_directory_mappings {
	entry  = "/"
	target = "/${aws_s3_bucket.foo.id}/$${Transfer:UserName}"
}
```

### Posix Profile

* ``gid`- (Required) The POSIX group ID used for all EFS operations by this user.
* ``uid`- (Required) The POSIX user ID used for all EFS operations by this user.
* ``secondaryGids`- (Optional) The secondary POSIX group IDs used for all EFS operations by this user.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* ``arn`- Amazon Resource Name (ARN) of Transfer User
* ``tagsAll`- A map of tags assigned to the resource, including those inherited from the provider [``defaultTags`configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* ``delete`- (Default ``10M`

## Import

Transfer Users can be imported using the ``serverId`and ``userName`separated by `/`.

```
$ terraform import aws_transfer_user.bar s-12345678/test-username
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c0c04519dcad5cffa36cf1eeeec079d6ecc672161deac90face184d04b172945 -->