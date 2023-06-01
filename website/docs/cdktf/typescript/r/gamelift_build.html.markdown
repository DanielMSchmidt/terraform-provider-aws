---
subcategory: "GameLift"
layout: "aws"
page_title: "AWS: aws_gamelift_build"
description: |-
  Provides a GameLift Build resource.
---

# Resource: aws_gamelift_build

Provides an GameLift Build resource.

## Example Usage

```terraform
resource "aws_gamelift_build" "test" {
  name             = "example-build"
  operating_system = "WINDOWS_2012"

  storage_location {
    bucket   = aws_s3_bucket.test.id
    key      = aws_s3_object.test.key
    role_arn = aws_iam_role.test.arn
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the build
* `operatingSystem` - (Required) Operating system that the game server binaries are built to run onE.g., `windows2012`, `amazonLinux` or `amazonLinux2`.
* `storageLocation` - (Required) Information indicating where your game build files are stored. See below.
* `version` - (Optional) Version that is associated with this build.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Nested Fields

#### `storageLocation`

* `bucket` - (Required) Name of your S3 bucket.
* `key` - (Required) Name of the zip file containing your build files.
* `roleArn` - (Required) ARN of the access role that allows Amazon GameLift to access your S3 bucket.
* `objectVersion` - (Optional) A specific version of the file. If not set, the latest version of the file is retrieved.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - GameLift Build ID.
* `arn` - GameLift Build ARN.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

GameLift Builds can be imported using the ID, e.g.,

```
$ terraform import aws_gamelift_build.example <build-id>
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b496779b799694c592ea4713e5f4bdc888ad2699dd2ad28e11ef72abdabe29dc -->