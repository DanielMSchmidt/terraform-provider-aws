---
subcategory: "Redshift"
layout: "aws"
page_title: "AWS: aws_redshift_partner"
description: |-
  Provides a Redshift Partner resource.
---

# Resource: aws_redshift_partner

Creates a new Amazon Redshift Partner Integration.

## Example Usage

```terraform
resource "aws_redshift_partner" "example" {
  cluster_identifier = aws_redshift_cluster.example.id
  account_id         = 01234567910
  database_name      = aws_redshift_cluster.example.database_name
  partner_name       = "example"
}
```

## Argument Reference

The following arguments are supported:

* `accountId` - (Required) The Amazon Web Services account ID that owns the cluster.
* `clusterIdentifier` - (Required) The cluster identifier of the cluster that receives data from the partner.
* `databaseName` - (Required) The name of the database that receives data from the partner.
* `partnerName` - (Required) The name of the partner that is authorized to send data.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The identifier of the Redshift partner, `accountId`, `clusterIdentifier`, `databaseName`, `partnerName` separated by a colon (`:`).
* `status` - (Optional) The partner integration status.
* `statusMessage` - (Optional) The status message provided by the partner.

## Import

Redshift usage limits can be imported using the `id`, e.g.,

```
$ terraform import aws_redshift_partner.example 01234567910:cluster-example-id:example:example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-5196c469ac4a6771b50478527c9c77186da2040686ec54661c0aef47be663176 -->