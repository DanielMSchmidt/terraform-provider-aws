---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_cluster"
description: |-
    Provides details about a specific redshift cluster
---

# Data Source: aws_redshift_cluster

Provides details about a specific redshift cluster.

## Example Usage

```terraform
data "aws_redshift_cluster" "example" {
  cluster_identifier = "example-cluster"
}

resource "aws_kinesis_firehose_delivery_stream" "example_stream" {
  name        = "terraform-kinesis-firehose-example-stream"
  destination = "redshift"

  s3_configuration {
    role_arn           = aws_iam_role.firehose_role.arn
    bucket_arn         = aws_s3_bucket.bucket.arn
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
  }

  redshift_configuration {
    role_arn           = aws_iam_role.firehose_role.arn
    cluster_jdbcurl    = "jdbc:redshift://${data.aws_redshift_cluster.example.endpoint}/${data.aws_redshift_cluster.example.database_name}"
    username           = "exampleuser"
    password           = "Exampl3Pass"
    data_table_name    = "example-table"
    copy_options       = "delimiter '|'" # the default delimiter
    data_table_columns = "example-col"
  }
}
```

## Argument Reference

The following arguments are supported:

* `clusterIdentifier` - (Required) Cluster identifier

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of cluster.
* `allowVersionUpgrade` - Whether major version upgrades can be applied during maintenance period
* `automatedSnapshotRetentionPeriod` - The backup retention period
* `aquaConfigurationStatus` - The value represents how the cluster is configured to use AQUA.
* `availabilityZone` - Availability zone of the cluster
* `availabilityZoneRelocationEnabled` - Indicates whether the cluster is able to be relocated to another availability zone.
* `bucketName` - Name of the S3 bucket where the log files are to be stored
* `clusterIdentifier` - Cluster identifier
* `clusterNodes` - Nodes in the cluster. Cluster node blocks are documented below
* `clusterParameterGroupName` - The name of the parameter group to be associated with this cluster
* `clusterPublicKey` - Public key for the cluster
* `clusterRevisionNumber` - The cluster revision number
* `clusterSubnetGroupName` - The name of a cluster subnet group to be associated with this cluster
* `clusterType` - Cluster type
* `databaseName` - Name of the default database in the cluster
* `defaultIamRoleArn` - ∂The ARN for the IAM role that was set as default for the cluster when the cluster was created.
* `elasticIp` - Elastic IP of the cluster
* `enableLogging` - Whether cluster logging is enabled
* `encrypted` - Whether the cluster data is encrypted
* `endpoint` - Cluster endpoint
* `enhancedVpcRouting` - Whether enhanced VPC routing is enabled
* `iamRoles` - IAM roles associated to the cluster
* `kmsKeyId` - KMS encryption key associated to the cluster
* `masterUsername` - Username for the master DB user
* `nodeType` - Cluster node type
* `numberOfNodes` - Number of nodes in the cluster
* `maintenanceTrackName` - The name of the maintenance track for the restored cluster.
* `manualSnapshotRetentionPeriod` - (Optional)  The default number of days to retain a manual snapshot.
* `port` - Port the cluster responds on
* `preferredMaintenanceWindow` - The maintenance window
* `publiclyAccessible` - Whether the cluster is publicly accessible
* `s3KeyPrefix` - Folder inside the S3 bucket where the log files are stored
* `logDestinationType` - The log destination type.
* `logExports` - Collection of exported log types. Log types include the connection log, user log and user activity log.
* `tags` - Tags associated to the cluster
* `vpcId` - VPC Id associated with the cluster
* `vpcSecurityGroupIds` - The VPC security group Ids associated with the cluster

Cluster nodes (for `clusterNodes`) support the following attributes:

* `nodeRole` - Whether the node is a leader node or a compute node
* `privateIpAddress` - Private IP address of a node within a cluster
* `publicIpAddress` - Public IP address of a node within a cluster

<!-- cache-key: cdktf-0.17.0-pre.15 input-51b789e18e0dccccf69afeffc404e397de7f10c677ea433649822d5952ed18db -->