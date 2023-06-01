---
subcategory: "Kinesis Analytics"
layout: "aws"
page_title: "AWS: aws_kinesis_analytics_application"
description: |-
  Provides a AWS Kinesis Analytics Application
---

# Resource: aws_kinesis_analytics_application

Provides a Kinesis Analytics Application resource. Kinesis Analytics is a managed service that
allows processing and analyzing streaming data using standard SQL.

For more details, see the [Amazon Kinesis Analytics Documentation][1].

-> **Note:** To manage Amazon Kinesis Data Analytics for Apache Flink applications, use the [`awsKinesisanalyticsv2Application`](/docs/providers/aws/r/kinesisanalyticsv2_application.html) resource.

## Example Usage

### Kinesis Stream Input

```terraform
resource "aws_kinesis_stream" "test_stream" {
  name        = "terraform-kinesis-test"
  shard_count = 1
}

resource "aws_kinesis_analytics_application" "test_application" {
  name = "kinesis-analytics-application-test"

  inputs {
    name_prefix = "test_prefix"

    kinesis_stream {
      resource_arn = aws_kinesis_stream.test_stream.arn
      role_arn     = aws_iam_role.test.arn
    }

    parallelism {
      count = 1
    }

    schema {
      record_columns {
        mapping  = "$.test"
        name     = "test"
        sql_type = "VARCHAR(8)"
      }

      record_encoding = "UTF-8"

      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
    }
  }
}
```

### Starting An Application

```terraform
resource "aws_cloudwatch_log_group" "example" {
  name = "analytics"
}

resource "aws_cloudwatch_log_stream" "example" {
  name           = "example-kinesis-application"
  log_group_name = aws_cloudwatch_log_group.example.name
}

resource "aws_kinesis_stream" "example" {
  name        = "example-kinesis-stream"
  shard_count = 1
}

resource "aws_kinesis_firehose_delivery_stream" "example" {
  name        = "example-kinesis-delivery-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    bucket_arn = aws_s3_bucket.example.arn
    role_arn   = aws_iam_role.example.arn
  }
}

resource "aws_kinesis_analytics_application" "test" {
  name = "example-application"

  cloudwatch_logging_options {
    log_stream_arn = aws_cloudwatch_log_stream.example.arn
    role_arn       = aws_iam_role.example.arn
  }

  inputs {
    name_prefix = "example_prefix"

    schema {
      record_columns {
        name     = "COLUMN_1"
        sql_type = "INTEGER"
      }

      record_format {
        mapping_parameters {
          csv {
            record_column_delimiter = ","
            record_row_delimiter    = "|"
          }
        }
      }
    }

    kinesis_stream {
      resource_arn = aws_kinesis_stream.example.arn
      role_arn     = aws_iam_role.example.arn
    }

    starting_position_configuration {
      starting_position = "NOW"
    }
  }

  outputs {
    name = "OUTPUT_1"

    schema {
      record_format_type = "CSV"
    }

    kinesis_firehose {
      resource_arn = aws_kinesis_firehose_delivery_stream.example.arn
      role_arn     = aws_iam_role.example.arn
    }
  }

  start_application = true
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the Kinesis Analytics Application.
* `code` - (Optional) SQL Code to transform input data, and generate output.
* `description` - (Optional) Description of the application.
* `cloudwatchLoggingOptions` - (Optional) The CloudWatch log stream options to monitor application errors.
See [CloudWatch Logging Options](#cloudwatch-logging-options) below for more details.
* `inputs` - (Optional) Input configuration of the application. See [Inputs](#inputs) below for more details.
* `outputs` - (Optional) Output destination configuration of the application. See [Outputs](#outputs) below for more details.
* `referenceDataSources` - (Optional) An S3 Reference Data Source for the application.
See [Reference Data Sources](#reference-data-sources) below for more details.
* `startApplication` - (Optional) Whether to start or stop the Kinesis Analytics Application. To start an application, an input with a defined `startingPosition` must be configured.
To modify an application's starting position, first stop the application by setting `start_application = false`, then update `startingPosition` and set `start_application = true`.
* `tags` - Key-value map of tags for the Kinesis Analytics Application. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### CloudWatch Logging Options

Configure a CloudWatch Log Stream to monitor application errors.

The `cloudwatchLoggingOptions` block supports the following:

* `logStreamArn` - (Required) The ARN of the CloudWatch Log Stream.
* `roleArn` - (Required) The ARN of the IAM Role used to send application messages.

### Inputs

Configure an Input for the Kinesis Analytics Application. You can only have 1 Input configured.

The `inputs` block supports the following:

* `namePrefix` - (Required) The Name Prefix to use when creating an in-application stream.
* `schema` - (Required) The Schema format of the data in the streaming source. See [Source Schema](#source-schema) below for more details.
* `kinesisFirehose` - (Optional) The Kinesis Firehose configuration for the streaming source. Conflicts with `kinesisStream`.
See [Kinesis Firehose](#kinesis-firehose) below for more details.
* `kinesisStream` - (Optional) The Kinesis Stream configuration for the streaming source. Conflicts with `kinesisFirehose`.
See [Kinesis Stream](#kinesis-stream) below for more details.
* `parallelism` - (Optional) The number of Parallel in-application streams to create.
See [Parallelism](#parallelism) below for more details.
* `processingConfiguration` - (Optional) The Processing Configuration to transform records as they are received from the stream.
See [Processing Configuration](#processing-configuration) below for more details.
* `startingPositionConfiguration` (Optional) The point at which the application starts processing records from the streaming source.
See [Starting Position Configuration](#starting-position-configuration) below for more details.

### Outputs

Configure Output destinations for the Kinesis Analytics Application. You can have a maximum of 3 destinations configured.

The `outputs` block supports the following:

* `name` - (Required) The Name of the in-application stream.
* `schema` - (Required) The Schema format of the data written to the destination. See [Destination Schema](#destination-schema) below for more details.
* `kinesisFirehose` - (Optional) The Kinesis Firehose configuration for the destination stream. Conflicts with `kinesisStream`.
See [Kinesis Firehose](#kinesis-firehose) below for more details.
* `kinesisStream` - (Optional) The Kinesis Stream configuration for the destination stream. Conflicts with `kinesisFirehose`.
See [Kinesis Stream](#kinesis-stream) below for more details.
* `lambda` - (Optional) The Lambda function destination. See [Lambda](#lambda) below for more details.

### Reference Data Sources

Add a Reference Data Source to the Kinesis Analytics Application. You can only have 1 Reference Data Source.

The `referenceDataSources` block supports the following:

* `schema` - (Required) The Schema format of the data in the streaming source. See [Source Schema](#source-schema) below for more details.
* `tableName` - (Required) The in-application Table Name.
* `s3` - (Optional) The S3 configuration for the reference data source. See [S3 Reference](#s3-reference) below for more details.

#### Kinesis Firehose

Configuration for a Kinesis Firehose delivery stream.

The `kinesisFirehose` block supports the following:

* `resourceArn` - (Required) The ARN of the Kinesis Firehose delivery stream.
* `roleArn` - (Required) The ARN of the IAM Role used to access the stream.

#### Kinesis Stream

Configuration for a Kinesis Stream.

The `kinesisStream` block supports the following:

* `resourceArn` - (Required) The ARN of the Kinesis Stream.
* `roleArn` - (Required) The ARN of the IAM Role used to access the stream.

#### Destination Schema

The Schema format of the data in the destination.

The `schema` block supports the following:

* `recordFormatType` - (Required) The Format Type of the records on the output stream. Can be `csv` or `json`.

#### Source Schema

The Schema format of the data in the streaming source.

The `schema` block supports the following:

* `recordColumns` - (Required) The Record Column mapping for the streaming source data element.
See [Record Columns](#record-columns) below for more details.
* `recordFormat` - (Required) The Record Format and mapping information to schematize a record.
See [Record Format](#record-format) below for more details.
* `recordEncoding` - (Optional) The Encoding of the record in the streaming source.

#### Parallelism

Configures the number of Parallel in-application streams to create.

The `parallelism` block supports the following:

* `count` - (Required) The Count of streams.

#### Processing Configuration

The Processing Configuration to transform records as they are received from the stream.

The `processingConfiguration` block supports the following:

* `lambda` - (Required) The Lambda function configuration. See [Lambda](#lambda) below for more details.

#### Lambda

The Lambda function that pre-processes records in the stream.

The `lambda` block supports the following:

* `resourceArn` - (Required) The ARN of the Lambda function.
* `roleArn` - (Required) The ARN of the IAM Role used to access the Lambda function.

#### Starting Position Configuration

The point at which the application reads from the streaming source.

The `startingPositionConfiguration` block supports the following:

* `startingPosition` - (Required) The starting position on the stream. Valid values: `lastStoppedPoint`, `now`, `trimHorizon`.

#### Record Columns

The Column mapping of each data element in the streaming source to the corresponding column in the in-application stream.

The `recordColumns` block supports the following:

* `name` - (Required) Name of the column.
* `sqlType` - (Required) The SQL Type of the column.
* `mapping` - (Optional) The Mapping reference to the data element.

#### Record Format

The Record Format and relevant mapping information that should be applied to schematize the records on the stream.

The `recordFormat` block supports the following:

* `recordFormatType` - (Required) The type of Record Format. Can be `csv` or `json`.
* `mappingParameters` - (Optional) The Mapping Information for the record format.
See [Mapping Parameters](#mapping-parameters) below for more details.

#### Mapping Parameters

Provides Mapping information specific to the record format on the streaming source.

The `mappingParameters` block supports the following:

* `csv` - (Optional) Mapping information when the record format uses delimiters.
See [CSV Mapping Parameters](#csv-mapping-parameters) below for more details.
* `json` - (Optional) Mapping information when JSON is the record format on the streaming source.
See [JSON Mapping Parameters](#json-mapping-parameters) below for more details.

#### CSV Mapping Parameters

Mapping information when the record format uses delimiters.

The `csv` block supports the following:

* `recordColumnDelimiter` - (Required) The Column Delimiter.
* `recordRowDelimiter` - (Required) The Row Delimiter.

#### JSON Mapping Parameters

Mapping information when JSON is the record format on the streaming source.

The `json` block supports the following:

* `recordRowPath` - (Required) Path to the top-level parent that contains the records.

#### S3 Reference

Identifies the S3 bucket and object that contains the reference data.

The `s3` blcok supports the following:

* `bucketArn` - (Required) The S3 Bucket ARN.
* `fileKey` - (Required) The File Key name containing reference data.
* `roleArn` - (Required) The IAM Role ARN to read the data.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ARN of the Kinesis Analytics Application.
* `arn` - The ARN of the Kinesis Analytics Appliation.
* `createTimestamp` - The Timestamp when the application version was created.
* `lastUpdateTimestamp` - The Timestamp when the application was last updated.
* `status` - The Status of the application.
* `version` - The Version of the application.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

[1]: https://docs.aws.amazon.com/kinesisanalytics/latest/dev/what-is.html

## Import

Kinesis Analytics Application can be imported by using ARN, e.g.,

```
$ terraform import aws_kinesis_analytics_application.example arn:aws:kinesisanalytics:us-west-2:1234567890:application/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-4789ffc4b9d2c739bd7338fd340b1ee60970e4706830ea376f8e7122517133a2 -->