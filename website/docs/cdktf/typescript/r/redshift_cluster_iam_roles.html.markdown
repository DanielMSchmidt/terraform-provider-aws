---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_cluster_iam_roles"
description: |-
  Provides a Redshift Cluster IAM Roles resource.
---

# Resource: aws_redshift_cluster_iam_roles

Provides a Redshift Cluster IAM Roles resource.

~> **NOTE:** A Redshift cluster's default IAM role can be managed both by this resource's `defaultIamRoleArn` argument and the [`awsRedshiftCluster`](redshift_cluster.html) resource's `defaultIamRoleArn` argument. Do not configure different values for both arguments. Doing so will cause a conflict of default IAM roles.

## Example Usage

```terraform
resource "aws_redshift_cluster_iam_roles" "example" {
  cluster_identifier = aws_redshift_cluster.example.cluster_identifier
  iam_role_arns      = [aws_iam_role.example.arn]
}
```

## Argument Reference

The following arguments are supported:

* `clusterIdentifier` - (Required) The name of the Redshift Cluster IAM Roles.
* `iamRoleArns` - (Optional) A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time.
* `defaultIamRoleArn` - (Optional) The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Redshift Cluster ID.

## Import

Redshift Cluster IAM Roless can be imported using the `clusterIdentifier`, e.g.,

```
$ terraform import aws_redshift_cluster_iam_roles.examplegroup1 example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7d6dc68627494aa4fdf42a577cea03d185bf21f1588a144f193340697767db2a -->