---
subcategory: "Kinesis Analytics V2"
layout: "aws"
page_title: "AWS: aws_kinesisanalyticsv2_application"
description: |-
  Manages a Kinesis Analytics v2 Application.
---

# Resource: aws_kinesisanalyticsv2_application

Manages a Kinesis Analytics v2 Application.
This resource can be used to manage both Kinesis Data Analytics for SQL applications and Kinesis Data Analytics for Apache Flink applications.

-> **Note:** Kinesis Data Analytics for SQL applications created using this resource cannot currently be viewed in the AWS Console. To manage Kinesis Data Analytics for SQL applications that can also be viewed in the AWS Console, use the [`awsKinesisAnalyticsApplication`](/docs/providers/aws/r/kinesis_analytics_application.html) resource.

## Example Usage

### Apache Flink Application

```terraform
resource "aws_s3_bucket" "example" {
  bucket = "example-flink-application"
}

resource "aws_s3_object" "example" {
  bucket = aws_s3_bucket.example.id
  key    = "example-flink-application"
  source = "flink-app.jar"
}

resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = "example-flink-application"
  runtime_environment    = "FLINK-1_8"
  service_execution_role = aws_iam_role.example.arn

  application_configuration {
    application_code_configuration {
      code_content {
        s3_content_location {
          bucket_arn = aws_s3_bucket.example.arn
          file_key   = aws_s3_object.example.key
        }
      }

      code_content_type = "ZIPFILE"
    }

    environment_properties {
      property_group {
        property_group_id = "PROPERTY-GROUP-1"

        property_map = {
          Key1 = "Value1"
        }
      }

      property_group {
        property_group_id = "PROPERTY-GROUP-2"

        property_map = {
          KeyA = "ValueA"
          KeyB = "ValueB"
        }
      }
    }

    flink_application_configuration {
      checkpoint_configuration {
        configuration_type = "DEFAULT"
      }

      monitoring_configuration {
        configuration_type = "CUSTOM"
        log_level          = "DEBUG"
        metrics_level      = "TASK"
      }

      parallelism_configuration {
        auto_scaling_enabled = true
        configuration_type   = "CUSTOM"
        parallelism          = 10
        parallelism_per_kpu  = 4
      }
    }
  }

  tags = {
    Environment = "test"
  }
}
```

### SQL Application

```terraform
resource "aws_cloudwatch_log_group" "example" {
  name = "example-sql-application"
}

resource "aws_cloudwatch_log_stream" "example" {
  name           = "example-sql-application"
  log_group_name = aws_cloudwatch_log_group.example.name
}

resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = "example-sql-application"
  runtime_environment    = "SQL-1_0"
  service_execution_role = aws_iam_role.example.arn

  application_configuration {
    application_code_configuration {
      code_content {
        text_content = "SELECT 1;\n"
      }

      code_content_type = "PLAINTEXT"
    }

    sql_application_configuration {
      input {
        name_prefix = "PREFIX_1"

        input_parallelism {
          count = 3
        }

        input_schema {
          record_column {
            name     = "COLUMN_1"
            sql_type = "VARCHAR(8)"
            mapping  = "MAPPING-1"
          }

          record_column {
            name     = "COLUMN_2"
            sql_type = "DOUBLE"
          }

          record_encoding = "UTF-8"

          record_format {
            record_format_type = "CSV"

            mapping_parameters {
              csv_mapping_parameters {
                record_column_delimiter = ","
                record_row_delimiter    = "\n"
              }
            }
          }
        }

        kinesis_streams_input {
          resource_arn = aws_kinesis_stream.example.arn
        }
      }

      output {
        name = "OUTPUT_1"

        destination_schema {
          record_format_type = "JSON"
        }

        lambda_output {
          resource_arn = aws_lambda_function.example.arn
        }
      }

      output {
        name = "OUTPUT_2"

        destination_schema {
          record_format_type = "CSV"
        }

        kinesis_firehose_output {
          resource_arn = aws_kinesis_firehose_delivery_stream.example.arn
        }
      }

      reference_data_source {
        table_name = "TABLE-1"

        reference_schema {
          record_column {
            name     = "COLUMN_1"
            sql_type = "INTEGER"
          }

          record_format {
            record_format_type = "JSON"

            mapping_parameters {
              json_mapping_parameters {
                record_row_path = "$"
              }
            }
          }
        }

        s3_reference_data_source {
          bucket_arn = aws_s3_bucket.example.arn
          file_key   = "KEY-1"
        }
      }
    }
  }

  cloudwatch_logging_options {
    log_stream_arn = aws_cloudwatch_log_stream.example.arn
  }
}
```

### VPC Configuration

```terraform
resource "aws_s3_bucket" "example" {
  bucket = "example-flink-application"
}

resource "aws_s3_object" "example" {
  bucket = aws_s3_bucket.example.id
  key    = "example-flink-application"
  source = "flink-app.jar"
}

resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = "example-flink-application"
  runtime_environment    = "FLINK-1_8"
  service_execution_role = aws_iam_role.example.arn

  application_configuration {
    application_code_configuration {
      code_content {
        s3_content_location {
          bucket_arn = aws_s3_bucket.example.arn
          file_key   = aws_s3_object.example.key
        }
      }

      code_content_type = "ZIPFILE"
    }

    vpc_configuration {
      security_group_ids = [aws_security_group.example[0].id, aws_security_group.example[1].id]
      subnet_ids         = [aws_subnet.example.id]
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the application.
* `runtimeEnvironment` - (Required) The runtime environment for the application. Valid values: `sql10`, `flink16`, `flink18`, `flink111`, `flink113`, `flink115`.
* `serviceExecutionRole` - (Required) The ARN of the [IAM role](/docs/providers/aws/r/iam_role.html) used by the application to access Kinesis data streams, Kinesis Data Firehose delivery streams, Amazon S3 objects, and other external resources.
* `applicationConfiguration` - (Optional) The application's configuration
* `cloudwatchLoggingOptions` - (Optional) A [CloudWatch log stream](/docs/providers/aws/r/cloudwatch_log_stream.html) to monitor application configuration errors.
* `description` - (Optional) A summary description of the application.
* `forceStop` - (Optional) Whether to force stop an unresponsive Flink-based application.
* `startApplication` - (Optional) Whether to start or stop the application.
* `tags` - (Optional) A map of tags to assign to the application. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

The `applicationConfiguration` object supports the following:

* `applicationCodeConfiguration` - (Required) The code location and type parameters for the application.
* `applicationSnapshotConfiguration` - (Optional) Describes whether snapshots are enabled for a Flink-based application.
* `environmentProperties` - (Optional) Describes execution properties for a Flink-based application.
* `flinkApplicationConfiguration` - (Optional) The configuration of a Flink-based application.
* `runConfiguration` - (Optional) Describes the starting properties for a Flink-based application.
* `sqlApplicationConfiguration` - (Optional) The configuration of a SQL-based application.
* `vpcConfiguration` - (Optional) The VPC configuration of a Flink-based application.

The `applicationCodeConfiguration` object supports the following:

* `codeContentType` - (Required) Specifies whether the code content is in text or zip format. Valid values: `plaintext`, `zipfile`.
* `codeContent` - (Optional) The location and type of the application code.

The `codeContent` object supports the following:

* `s3ContentLocation` - (Optional) Information about the Amazon S3 bucket containing the application code.
* `textContent` - (Optional) The text-format code for the application.

The `s3ContentLocation` object supports the following:

* `bucketArn` - (Required) The ARN for the S3 bucket containing the application code.
* `fileKey` - (Required) The file key for the object containing the application code.
* `objectVersion` - (Optional) The version of the object containing the application code.

The `applicationSnapshotConfiguration` object supports the following:

* `snapshotsEnabled` - (Required) Describes whether snapshots are enabled for a Flink-based Kinesis Data Analytics application.

The `environmentProperties` object supports the following:

* `propertyGroup` - (Required) Describes the execution property groups.

The `propertyGroup` object supports the following:

* `propertyGroupId` - (Required) The key of the application execution property key-value map.
* `propertyMap` - (Required) Application execution property key-value map.

The `flinkApplicationConfiguration` object supports the following:

* `checkpointConfiguration` - (Optional) Describes an application's checkpointing configuration.
* `monitoringConfiguration` - (Optional) Describes configuration parameters for CloudWatch logging for an application.
* `parallelismConfiguration` - (Optional) Describes parameters for how an application executes multiple tasks simultaneously.

The `checkpointConfiguration` object supports the following:

* `configurationType` - (Required) Describes whether the application uses Kinesis Data Analytics' default checkpointing behavior. Valid values: `custom`, `default`. Set this attribute to `custom` in order for any specified `checkpointingEnabled`, `checkpointInterval`, or `minPauseBetweenCheckpoints` attribute values to be effective. If this attribute is set to `default`, the application will always use the following values:
    * `checkpointing_enabled = true`
    * `checkpoint_interval = 60000`
    * `min_pause_between_checkpoints = 5000`
* `checkpointingEnabled` - (Optional) Describes whether checkpointing is enabled for a Flink-based Kinesis Data Analytics application.
* `checkpointInterval` - (Optional) Describes the interval in milliseconds between checkpoint operations.
* `minPauseBetweenCheckpoints` - (Optional) Describes the minimum time in milliseconds after a checkpoint operation completes that a new checkpoint operation can start.

The `monitoringConfiguration` object supports the following:

* `configurationType` - (Required) Describes whether to use the default CloudWatch logging configuration for an application. Valid values: `custom`, `default`. Set this attribute to `custom` in order for any specified `logLevel` or `metricsLevel` attribute values to be effective.
* `logLevel` - (Optional) Describes the verbosity of the CloudWatch Logs for an application. Valid values: `debug`, `error`, `info`, `warn`.
* `metricsLevel` - (Optional) Describes the granularity of the CloudWatch Logs for an application. Valid values: `application`, `operator`, `parallelism`, `task`.

The `parallelismConfiguration` object supports the following:

* `configurationType` - (Required) Describes whether the application uses the default parallelism for the Kinesis Data Analytics service. Valid values: `custom`, `default`. Set this attribute to `custom` in order for any specified `autoScalingEnabled`, `parallelism`, or `parallelismPerKpu` attribute values to be effective.
* `autoScalingEnabled` - (Optional) Describes whether the Kinesis Data Analytics service can increase the parallelism of the application in response to increased throughput.
* `parallelism` - (Optional) Describes the initial number of parallel tasks that a Flink-based Kinesis Data Analytics application can perform.
* `parallelismPerKpu` - (Optional) Describes the number of parallel tasks that a Flink-based Kinesis Data Analytics application can perform per Kinesis Processing Unit (KPU) used by the application.

The `runConfiguration` object supports the following:

* `applicationRestoreConfiguration` - (Optional) The restore behavior of a restarting application.
* `flinkRunConfiguration` - (Optional) The starting parameters for a Flink-based Kinesis Data Analytics application.

The `applicationRestoreConfiguration` object supports the following:

* `applicationRestoreType` - (Required) Specifies how the application should be restored. Valid values: `restoreFromCustomSnapshot`, `restoreFromLatestSnapshot`, `skipRestoreFromSnapshot`.
* `snapshotName` - (Optional) The identifier of an existing snapshot of application state to use to restart an application. The application uses this value if `restoreFromCustomSnapshot` is specified for `applicationRestoreType`.

The `flinkRunConfiguration` object supports the following:

* `allowNonRestoredState` - (Optional) When restoring from a snapshot, specifies whether the runtime is allowed to skip a state that cannot be mapped to the new program. Default is `false`.

The `sqlApplicationConfiguration` object supports the following:

* `input` - (Optional) The input stream used by the application.
* `output` - (Optional) The destination streams used by the application.
* `referenceDataSource` - (Optional) The reference data source used by the application.

The `input` object supports the following:

* `inputSchema` - (Required) Describes the format of the data in the streaming source, and how each data element maps to corresponding columns in the in-application stream that is being created.
* `namePrefix` - (Required) The name prefix to use when creating an in-application stream.
* `inputParallelism` - (Optional) Describes the number of in-application streams to create.
* `inputProcessingConfiguration` - (Optional) The input processing configuration for the input.
An input processor transforms records as they are received from the stream, before the application's SQL code executes.
* `inputStartingPositionConfiguration` (Optional) The point at which the application starts processing records from the streaming source.
* `kinesisFirehoseInput` - (Optional) If the streaming source is a [Kinesis Data Firehose delivery stream](/docs/providers/aws/r/kinesis_firehose_delivery_stream.html), identifies the delivery stream's ARN.
* `kinesisStreamsInput` - (Optional) If the streaming source is a [Kinesis data stream](/docs/providers/aws/r/kinesis_stream.html), identifies the stream's Amazon Resource Name (ARN).

The `inputParallelism` object supports the following:

* `count` - (Optional) The number of in-application streams to create.

The `inputProcessingConfiguration` object supports the following:

* `inputLambdaProcessor` - (Required) Describes the [Lambda function](/docs/providers/aws/r/lambda_function.html) that is used to preprocess the records in the stream before being processed by your application code.

The `inputLambdaProcessor` object supports the following:

* `resourceArn` - (Required) The ARN of the Lambda function that operates on records in the stream.

The `inputSchema` object supports the following:

* `recordColumn` - (Required) Describes the mapping of each data element in the streaming source to the corresponding column in the in-application stream.
* `recordFormat` - (Required) Specifies the format of the records on the streaming source.
* `recordEncoding` - (Optional) Specifies the encoding of the records in the streaming source. For example, `utf8`.

The `recordColumn` object supports the following:

* `name` - (Required) The name of the column that is created in the in-application input stream or reference table.
* `sqlType` - (Required) The type of column created in the in-application input stream or reference table.
* `mapping` - (Optional) A reference to the data element in the streaming input or the reference data source.

The `recordFormat` object supports the following:

* `mappingParameters` - (Required) Provides additional mapping information specific to the record format (such as JSON, CSV, or record fields delimited by some delimiter) on the streaming source.
* `recordFormatType` - (Required) The type of record format. Valid values: `csv`, `json`.

The `mappingParameters` object supports the following:

* `csvMappingParameters` - (Optional) Provides additional mapping information when the record format uses delimiters (for example, CSV).
* `jsonMappingParameters` - (Optional) Provides additional mapping information when JSON is the record format on the streaming source.

The `csvMappingParameters` object supports the following:

* `recordColumnDelimiter` - (Required) The column delimiter. For example, in a CSV format, a comma (`,`) is the typical column delimiter.
* `recordRowDelimiter` - (Required) The row delimiter. For example, in a CSV format, `\n` is the typical row delimiter.

The `jsonMappingParameters` object supports the following:

* `recordRowPath` - (Required) The path to the top-level parent that contains the records.

The `inputStartingPositionConfiguration` object supports the following:

~> **NOTE:** To modify an application's starting position, first stop the application by setting `start_application = false`, then update `startingPosition` and set `start_application = true`.

* `inputStartingPosition` - (Required) The starting position on the stream. Valid values: `lastStoppedPoint`, `now`, `trimHorizon`.

The `kinesisFirehoseInput` object supports the following:

* `resourceArn` - (Required) The ARN of the delivery stream.

The `kinesisStreamsInput` object supports the following:

* `resourceArn` - (Required) The ARN of the input Kinesis data stream to read.

The `output` object supports the following:

* `destinationSchema` - (Required) Describes the data format when records are written to the destination.
* `name` - (Required) The name of the in-application stream.
* `kinesisFirehoseOutput` - (Optional) Identifies a [Kinesis Data Firehose delivery stream](/docs/providers/aws/r/kinesis_firehose_delivery_stream.html) as the destination.
* `kinesisStreamsOutput` - (Optional) Identifies a [Kinesis data stream](/docs/providers/aws/r/kinesis_stream.html) as the destination.
* `lambdaOutput` - (Optional) Identifies a [Lambda function](/docs/providers/aws/r/lambda_function.html) as the destination.

The `destinationSchema` object supports the following:

* `recordFormatType` - (Required) Specifies the format of the records on the output stream. Valid values: `csv`, `json`.

The `kinesisFirehoseOutput` object supports the following:

* `resourceArn` - (Required) The ARN of the destination delivery stream to write to.

The `kinesisStreamsOutput` object supports the following:

* `resourceArn` - (Required) The ARN of the destination Kinesis data stream to write to.

The `lambdaOutput` object supports the following:

* `resourceArn` - (Required) The ARN of the destination Lambda function to write to.

The `referenceDataSource` object supports the following:

* `referenceSchema` - (Required) Describes the format of the data in the streaming source, and how each data element maps to corresponding columns created in the in-application stream.
* `s3ReferenceDataSource` - (Required) Identifies the S3 bucket and object that contains the reference data.
* `tableName` - (Required) The name of the in-application table to create.

The `referenceSchema` object supports the following:

* `recordColumn` - (Required) Describes the mapping of each data element in the streaming source to the corresponding column in the in-application stream.
* `recordFormat` - (Required) Specifies the format of the records on the streaming source.
* `recordEncoding` - (Optional) Specifies the encoding of the records in the streaming source. For example, `utf8`.

The `s3ReferenceDataSource` object supports the following:

* `bucketArn` - (Required) The ARN of the S3 bucket.
* `fileKey` - (Required) The object key name containing the reference data.

The `vpcConfiguration` object supports the following:

* `securityGroupIds` - (Required) The [Security Group](/docs/providers/aws/r/security_group.html) IDs used by the VPC configuration.
* `subnetIds` - (Required) The [Subnet](/docs/providers/aws/r/subnet.html) IDs used by the VPC configuration.

The `cloudwatchLoggingOptions` object supports the following:

* `logStreamArn` - (Required) The ARN of the CloudWatch log stream to receive application messages.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The application identifier.
* `arn` - The ARN of the application.
* `createTimestamp` - The current timestamp when the application was created.
* `lastUpdateTimestamp` - The current timestamp when the application was last updated.
* `status` - The status of the application.
* `versionId` - The current application version. Kinesis Data Analytics updates the `versionId` each time the application is updated.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

- `create` - (Default `10M`)
- `update` - (Default `10M`)
- `delete` - (Default `10M`)

## Import

`awsKinesisanalyticsv2Application` can be imported by using the application ARN, e.g.,

```
$ terraform import aws_kinesisanalyticsv2_application.example arn:aws:kinesisanalytics:us-west-2:123456789012:application/example-sql-application
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-a2465ed1599390eaaeb60342cc45dba1967f6e8468e50c5a64586ef135741f44 -->