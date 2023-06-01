---
subcategory: "S3 Control"
layout: "aws"
page_title: "AWS: aws_s3control_object_lambda_access_point"
description: |-
  Provides a resource to manage an S3 Object Lambda Access Point.
---

# Resource: aws_s3control_object_lambda_access_point

Provides a resource to manage an S3 Object Lambda Access Point.
An Object Lambda access point is associated with exactly one [standard access point](s3_access_point.html) and thus one Amazon S3 bucket.

## Example Usage

```terraform
resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_access_point" "example" {
  bucket = aws_s3_bucket.example.id
  name   = "example"
}

resource "aws_s3control_object_lambda_access_point" "example" {
  name = "example"

  configuration {
    supporting_access_point = aws_s3_access_point.example.arn

    transformation_configuration {
      actions = ["GetObject"]

      content_transformation {
        aws_lambda {
          function_arn = aws_lambda_function.example.arn
        }
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `accountId` - (Optional) The AWS account ID for the owner of the bucket for which you want to create an Object Lambda Access Point. Defaults to automatically determined account ID of the Terraform AWS provider.
* `configuration` - (Required) A configuration block containing details about the Object Lambda Access Point. See [Configuration](#configuration) below for more details.
* `name` - (Required) The name for this Object Lambda Access Point.

### Configuration

The `configuration` block supports the following:

* `allowedFeatures` - (Optional) Allowed features. Valid values: `getObjectRange`, `getObjectPartNumber`.
* `cloudWatchMetricsEnabled` - (Optional) Whether or not the CloudWatch metrics configuration is enabled.
* `supportingAccessPoint` - (Required) Standard access point associated with the Object Lambda Access Point.
* `transformationConfiguration` - (Required) List of transformation configurations for the Object Lambda Access Point. See [Transformation Configuration](#transformation-configuration) below for more details.

### Transformation Configuration

The `transformationConfiguration` block supports the following:

* `actions` - (Required) The actions of an Object Lambda Access Point configuration. Valid values: `getObject`.
* `contentTransformation` - (Required) The content transformation of an Object Lambda Access Point configuration. See [Content Transformation](#content-transformation) below for more details.

### Content Transformation

The `contentTransformation` block supports the following:

* `awsLambda` - (Required) Configuration for an AWS Lambda function. See [AWS Lambda](#aws-lambda) below for more details.

### AWS Lambda

The `awsLambda` block supports the following:

* `functionArn` - (Required) The Amazon Resource Name (ARN) of the AWS Lambda function.
* `functionPayload` - (Optional) Additional JSON that provides supplemental data to the Lambda function used to transform objects.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Object Lambda Access Point.
* `id` - The AWS account ID and access point name separated by a colon (`:`).

## Import

Object Lambda Access Points can be imported using the `accountId` and `name`, separated by a colon (`:`), e.g.

```
$ terraform import aws_s3control_object_lambda_access_point.example 123456789012:example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-1a7dc1553e3619d05d79cb8ac022470a38c1c4e3fa9f2271fdc842c54ede2e55 -->