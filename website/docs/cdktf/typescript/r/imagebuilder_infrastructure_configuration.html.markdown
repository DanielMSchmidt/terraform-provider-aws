---
subcategory: "EC2 Image Builder"
layout: "aws"
page_title: "AWS: aws_imagebuilder_infrastructure_configuration"
description: |-
  Manages an Image Builder Infrastructure Configuration
---

# Resource: aws_imagebuilder_infrastructure_configuration

Manages an Image Builder Infrastructure Configuration.

## Example Usage

```terraform
resource "aws_imagebuilder_infrastructure_configuration" "example" {
  description                   = "example description"
  instance_profile_name         = aws_iam_instance_profile.example.name
  instance_types                = ["t2.nano", "t3.micro"]
  key_pair                      = aws_key_pair.example.key_name
  name                          = "example"
  security_group_ids            = [aws_security_group.example.id]
  sns_topic_arn                 = aws_sns_topic.example.arn
  subnet_id                     = aws_subnet.main.id
  terminate_instance_on_failure = true

  logging {
    s3_logs {
      s3_bucket_name = aws_s3_bucket.example.bucket
      s3_key_prefix  = "logs"
    }
  }

  tags = {
    foo = "bar"
  }
}
```

## Argument Reference

The following arguments are required:

* `instanceProfileName` - (Required) Name of IAM Instance Profile.
* `name` - (Required) Name for the configuration.

The following arguments are optional:

* `description` - (Optional) Description for the configuration.
* `instanceMetadataOptions` - (Optional) Configuration block with instance metadata options for the HTTP requests that pipeline builds use to launch EC2 build and test instances. Detailed below.
* `instanceTypes` - (Optional) Set of EC2 Instance Types.
* `keyPair` - (Optional) Name of EC2 Key Pair.
* `logging` - (Optional) Configuration block with logging settings. Detailed below.
* `resourceTags` - (Optional) Key-value map of resource tags to assign to infrastructure created by the configuration.
* `securityGroupIds` - (Optional) Set of EC2 Security Group identifiers.
* `snsTopicArn` - (Optional) Amazon Resource Name (ARN) of SNS Topic.
* `subnetId` - (Optional) EC2 Subnet identifier. Also requires `securityGroupIds` argument.
* `tags` - (Optional) Key-value map of resource tags to assign to the configuration. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `terminateInstanceOnFailure` - (Optional) Enable if the instance should be terminated when the pipeline fails. Defaults to `false`.

### instance_metadata_options

The following arguments are optional:

* `httpPutResponseHopLimit` - The number of hops that an instance can traverse to reach its destonation.
* `httpTokens` - Whether a signed token is required for instance metadata retrieval requests. Valid values: `required`, `optional`.

### logging

The following arguments are required:

* `s3Logs` - (Required) Configuration block with S3 logging settings. Detailed below.

### s3_logs

The following arguments are required:

* `s3BucketName` - (Required) Name of the S3 Bucket.

The following arguments are optional:

* `s3KeyPrefix` - (Optional) Prefix to use for S3 logs. Defaults to `/`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Amazon Resource Name (ARN) of the configuration.
* `arn` - Amazon Resource Name (ARN) of the configuration.
* `dateCreated` - Date when the configuration was created.
* `dateUpdated` - Date when the configuration was updated.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsImagebuilderInfrastructureConfiguration` can be imported using the Amazon Resource Name (ARN), e.g.,

```
$ terraform import aws_imagebuilder_infrastructure_configuration.example arn:aws:imagebuilder:us-east-1:123456789012:infrastructure-configuration/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-bc0a4a0d32bd98d885c72940930239a41ceec753397b3bf395656ad344bde50e -->