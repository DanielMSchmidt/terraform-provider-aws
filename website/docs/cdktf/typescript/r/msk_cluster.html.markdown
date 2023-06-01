---
subcategory: "Managed Streaming for Kafka"
layout: "aws"
page_title: "AWS: aws_msk_cluster"
description: |-
  Terraform resource for managing an AWS Managed Streaming for Kafka cluster.
---

# Resource: aws_msk_cluster

Manages an Amazon MSK cluster.

-> **Note:** This resource manages _provisioned_ clusters. To manage a _serverless_ Amazon MSK cluster, use the [`awsMskServerlessCluster`](/docs/providers/aws/r/msk_serverless_cluster.html) resource.

## Example Usage

### Basic

```terraform
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/22"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "192.168.0.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "192.168.1.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "192.168.2.0/24"
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_kms_key" "kms" {
  description = "example"
}

resource "aws_cloudwatch_log_group" "test" {
  name = "msk_broker_logs"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "msk-broker-logs-bucket"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "firehose_role" {
  name               = "firehose_test_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-msk-broker-logs-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }

  tags = {
    LogDeliveryEnabled = "placeholder"
  }

  lifecycle {
    ignore_changes = [
      tags["LogDeliveryEnabled"],
    ]
  }
}

resource "aws_msk_cluster" "example" {
  cluster_name           = "example"
  kafka_version          = "3.2.0"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type = "kafka.m5.large"
    client_subnets = [
      aws_subnet.subnet_az1.id,
      aws_subnet.subnet_az2.id,
      aws_subnet.subnet_az3.id,
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 1000
      }
    }
    security_groups = [aws_security_group.sg.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.test.name
      }
      firehose {
        enabled         = true
        delivery_stream = aws_kinesis_firehose_delivery_stream.test_stream.name
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.bucket.id
        prefix  = "logs/msk-"
      }
    }
  }

  tags = {
    foo = "bar"
  }
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.example.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.example.bootstrap_brokers_tls
}
```

### With volume_throughput argument

```terraform
resource "aws_msk_cluster" "example" {
  cluster_name           = "example"
  kafka_version          = "2.7.1"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type = "kafka.m5.4xlarge"
    client_subnets = [
      aws_subnet.subnet_az1.id,
      aws_subnet.subnet_az2.id,
      aws_subnet.subnet_az3.id,
    ]
    storage_info {
      ebs_storage_info {
        provisioned_throughput {
          enabled           = true
          volume_throughput = 250
        }
        volume_size = 1000
      }
    }
    security_groups = [aws_security_group.sg.id]
  }
}
```

## Argument Reference

The following arguments are supported:

* `brokerNodeGroupInfo` - (Required) Configuration block for the broker nodes of the Kafka cluster.
* `clusterName` - (Required) Name of the MSK cluster.
* `kafkaVersion` - (Required) Specify the desired Kafka software version.
* `numberOfBrokerNodes` - (Required) The desired total number of broker nodes in the kafka cluster.  It must be a multiple of the number of specified client subnets.
* `clientAuthentication` - (Optional) Configuration block for specifying a client authentication. See below.
* `configurationInfo` - (Optional) Configuration block for specifying a MSK Configuration to attach to Kafka brokers. See below.
* `encryptionInfo` - (Optional) Configuration block for specifying encryption. See below.
* `enhancedMonitoring` - (Optional) Specify the desired enhanced MSK CloudWatch monitoring level. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)
* `openMonitoring` - (Optional) Configuration block for JMX and Node monitoring for the MSK cluster. See below.
* `loggingInfo` - (Optional) Configuration block for streaming broker logs to Cloudwatch/S3/Kinesis Firehose. See below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### broker_node_group_info Argument Reference

* `clientSubnets` - (Required) A list of subnets to connect to in client VPC ([documentation](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-prop-brokernodegroupinfo-clientsubnets)).
* `instanceType` - (Required) Specify the instance type to use for the kafka brokersE.g., kafka.m5.large. ([Pricing info](https://aws.amazon.com/msk/pricing/))
* `securityGroups` - (Required) A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster.
* `azDistribution` - (Optional) The distribution of broker nodes across availability zones ([documentation](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-model-brokerazdistribution)). Currently the only valid value is `default`.
* `connectivityInfo` - (Optional) Information about the cluster access configuration. See below. For security reasons, you can't turn on public access while creating an MSK cluster. However, you can update an existing cluster to make it publicly accessible. You can also create a new cluster and then update it to make it publicly accessible ([documentation](https://docs.aws.amazon.com/msk/latest/developerguide/public-access.html)).
* `storageInfo` - (Optional) A block that contains information about storage volumes attached to MSK broker nodes. See below.

### broker_node_group_info connectivity_info Argument Reference

* `publicAccess` - (Optional) Access control settings for brokers. See below.

### connectivity_info public_access Argument Reference

* `type` - (Optional) Public access type. Valida values: `disabled`, `serviceProvidedEips`.

### broker_node_group_info storage_info Argument Reference

* `ebsStorageInfo` - (Optional) A block that contains EBS volume information. See below.

### storage_info ebs_storage_info Argument Reference

* `provisionedThroughput` - (Optional) A block that contains EBS volume provisioned throughput information. To provision storage throughput, you must choose broker type kafka.m5.4xlarge or larger. See below.
* `volumeSize` - (Optional) The size in GiB of the EBS volume for the data drive on each broker node. Minimum value of `1` and maximum value of `16384`.

### ebs_storage_info provisioned_throughput Argument Reference

* `enabled` - (Optional) Controls whether provisioned throughput is enabled or not. Default value: `false`.
* `volumeThroughput` - (Optional) Throughput value of the EBS volumes for the data drive on each kafka broker node in MiB per second. The minimum value is `250`. The maximum value varies between broker type. You can refer to the valid values for the maximum volume throughput at the following [documentation on throughput bottlenecks](https://docs.aws.amazon.com/msk/latest/developerguide/msk-provision-throughput.html#throughput-bottlenecks)

### client_authentication Argument Reference

* `sasl` - (Optional) Configuration block for specifying SASL client authentication. See below.
* `tls` - (Optional) Configuration block for specifying TLS client authentication. See below.
* `unauthenticated` - (Optional) Enables unauthenticated access.

#### client_authentication sasl Argument Reference

* `iam` - (Optional) Enables IAM client authentication. Defaults to `false`.
* `scram` - (Optional) Enables SCRAM client authentication via AWS Secrets Manager. Defaults to `false`.

#### client_authentication tls Argument Reference

* `certificateAuthorityArns` - (Optional) List of ACM Certificate Authority Amazon Resource Names (ARNs).

### configuration_info Argument Reference

* `arn` - (Required) Amazon Resource Name (ARN) of the MSK Configuration to use in the cluster.
* `revision` - (Required) Revision of the MSK Configuration to use in the cluster.

### encryption_info Argument Reference

* `encryptionInTransit` - (Optional) Configuration block to specify encryption in transit. See below.
* `encryptionAtRestKmsKeyArn` - (Optional) You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest.  If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest.

#### encryption_info encryption_in_transit Argument Reference

* `clientBroker` - (Optional) Encryption setting for data in transit between clients and brokers. Valid values: `tls`, `tlsPlaintext`, and `plaintext`. Default value is `tls`.
* `inCluster` - (Optional) Whether data communication among broker nodes is encrypted. Default value: `true`.

#### open_monitoring Argument Reference

* `prometheus` - (Required) Configuration block for Prometheus settings for open monitoring. See below.

#### open_monitoring prometheus Argument Reference

* `jmxExporter` - (Optional) Configuration block for JMX Exporter. See below.
* `nodeExporter` - (Optional) Configuration block for Node Exporter. See below.

#### open_monitoring prometheus jmx_exporter Argument Reference

* `enabledInBroker` - (Required) Indicates whether you want to enable or disable the JMX Exporter.

#### open_monitoring prometheus node_exporter Argument Reference

* `enabledInBroker` - (Required) Indicates whether you want to enable or disable the Node Exporter.

#### logging_info Argument Reference

* `brokerLogs` - (Required) Configuration block for Broker Logs settings for logging info. See below.

#### logging_info broker_logs cloudwatch_logs Argument Reference

* `enabled` - (Optional) Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs.
* `logGroup` - (Optional) Name of the Cloudwatch Log Group to deliver logs to.

#### logging_info broker_logs firehose Argument Reference

* `enabled` - (Optional) Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose.
* `deliveryStream` - (Optional) Name of the Kinesis Data Firehose delivery stream to deliver logs to.

#### logging_info broker_logs s3 Argument Reference

* `enabled` - (Optional) Indicates whether you want to enable or disable streaming broker logs to S3.
* `bucket` - (Optional) Name of the S3 bucket to deliver logs to.
* `prefix` - (Optional) Prefix to append to the folder name.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the MSK cluster.
* `bootstrapBrokers` - Comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster. Contains a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `plaintext` or `tlsPlaintext`. The resource sorts values alphabetically. AWS may not always return all endpoints so this value is not guaranteed to be stable across applies.
* `bootstrapBrokersPublicSaslIam` - One or more DNS names (or IP addresses) and SASL IAM port pairs. For example, `b1PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9198,b2PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9198,b3PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9198`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls` and `clientAuthentication0Sasl0Iam` is set to `true` and `brokerNodeGroupInfo0ConnectivityInfo0PublicAccess0Type` is set to `serviceProvidedEips` and the cluster fulfill all other requirements for public access. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `bootstrapBrokersPublicSaslScram` - One or more DNS names (or IP addresses) and SASL SCRAM port pairs. For example, `b1PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9196,b2PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9196,b3PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9196`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls` and `clientAuthentication0Sasl0Scram` is set to `true` and `brokerNodeGroupInfo0ConnectivityInfo0PublicAccess0Type` is set to `serviceProvidedEips` and the cluster fulfill all other requirements for public access. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `bootstrapBrokersPublicTls` - One or more DNS names (or IP addresses) and TLS port pairs. For example, `b1PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9194,b2PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9194,b3PublicExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9194`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls` and `brokerNodeGroupInfo0ConnectivityInfo0PublicAccess0Type` is set to `serviceProvidedEips` and the cluster fulfill all other requirements for public access. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `bootstrapBrokersSaslIam` - One or more DNS names (or IP addresses) and SASL IAM port pairs. For example, `b1ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9098,b2ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9098,b3ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9098`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls` and `clientAuthentication0Sasl0Iam` is set to `true`. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `bootstrapBrokersSaslScram` - One or more DNS names (or IP addresses) and SASL SCRAM port pairs. For example, `b1ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9096,b2ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9096,b3ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9096`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls` and `clientAuthentication0Sasl0Scram` is set to `true`. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `bootstrapBrokersTls` - One or more DNS names (or IP addresses) and TLS port pairs. For example, `b1ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9094,b2ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9094,b3ExampleClusterNameAbcdeC2KafkaUsEast1AmazonawsCom:9094`. This attribute will have a value if `encryptionInfo0EncryptionInTransit0ClientBroker` is set to `tlsPlaintext` or `tls`. The resource sorts the list alphabetically. AWS may not always return all endpoints so the values may not be stable across applies.
* `currentVersion` - Current version of the MSK Cluster used for updates, e.g., `k13V1Ib3Viyzzh`
* `encryptionInfo0EncryptionAtRestKmsKeyArn` - The ARN of the KMS key used for encryption at rest of the broker data volumes.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `storageMode` - Controls storage mode for supported storage tiers. Valid values are: `local` or `tiered`.
* `zookeeperConnectString` - A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. The returned values are sorted alphabetically. The AWS API may not return all endpoints, so this value is not guaranteed to be stable across applies.
* `zookeeperConnectStringTls` - A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster via TLS. The returned values are sorted alphabetically. The AWS API may not return all endpoints, so this value is not guaranteed to be stable across applies.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `120M`)
* `update` - (Default `120M`)
Note that the `update` timeout is used separately for `storageInfo`, `instanceType`, `numberOfBrokerNodes`, `configurationInfo`, `kafkaVersion` and monitoring and logging update timeouts.
* `delete` - (Default `120M`)

## Import

MSK clusters can be imported using the cluster `arn`, e.g.,

```
$ terraform import aws_msk_cluster.example arn:aws:kafka:us-west-2:123456789012:cluster/example/279c0212-d057-4dba-9aa9-1c4e5a25bfc7-3
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f030f19a5d031acc3032a8755cae66e517413472749e832ec727dcece7e4bddb -->