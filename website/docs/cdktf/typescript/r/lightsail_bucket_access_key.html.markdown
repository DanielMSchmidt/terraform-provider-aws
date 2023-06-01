---
subcategory: "Lightsail"
layout: "aws"
page_title: "AWS: aws_lightsail_bucket_access_key"
description: |-
  Provides a lightsail bucket access key. This is a set of credentials that allow API requests to be made to the lightsail bucket.
---

# Resource: aws_lightsail_bucket_access_key

Provides a lightsail bucket access key. This is a set of credentials that allow API requests to be made to the lightsail bucket.

## Example Usage

```terraform
resource "aws_lightsail_bucket" "test" {
  name      = "mytestbucket"
  bundle_id = "small_1_0"
}

resource "aws_lightsail_bucket_access_key_access_key" "test" {
  bucket_name = aws_lightsail_bucket_access_key.test.id
}
```

## Argument Reference

The following arguments are supported:

* `bucketName` - (Required) The name of the bucket that the new access key will belong to, and grant access to.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - A combination of attributes separated by a `,` to create a unique id: `bucketName`,`accessKeyId`
* `accessKeyId` - The ID of the access key.
* `createdAt` - The timestamp when the access key was created.
* `secretAccessKey` - The secret access key used to sign requests. This attribute is not available for imported resources. Note that this will be written to the state file.
* `status` - The status of the access key.

## Import

`awsLightsailBucketAccessKey` can be imported by using the `id` attribute, e.g.,

```
$ terraform import aws_lightsail_bucket_access_key.test example-bucket,AKIA47VOQ2KPR7LLRZ6D
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7c1d1915d1a96eb0be80f2b34f5992feb825065e97906e4f7cccabbd479081b2 -->