---
subcategory: "QuickSight"
layout: "aws"
page_title: "AWS: aws_quicksight_ingestion"
description: |-
  Terraform resource for managing an AWS QuickSight Ingestion.
---

# Resource: aws_quicksight_ingestion

Terraform resource for managing an AWS QuickSight Ingestion.

## Example Usage

### Basic Usage

```terraform
resource "aws_quicksight_ingestion" "example" {
  data_set_id    = aws_quicksight_data_set.example.data_set_id
  ingestion_id   = "example-id"
  ingestion_type = "FULL_REFRESH"
}
```

## Argument Reference

The following arguments are required:

* `dataSetId` - (Required) ID of the dataset used in the ingestion.
* `ingestionId` - (Required) ID for the ingestion.
* `ingestionType` - (Required) Type of ingestion to be created. Valid values are `incrementalRefresh` and `fullRefresh`.

The following arguments are optional:

* `awsAccountId` - (Optional) AWS account ID.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Ingestion.
* `id` - A comma-delimited string joining AWS account ID, data set ID, and ingestion ID.
* `ingestionStatus` - Ingestion status.

## Import

QuickSight Ingestion can be imported using the AWS account ID, data set ID, and ingestion ID separated by commas (`,`) e.g.,

```
$ terraform import aws_quicksight_ingestion.example 123456789012,example-dataset-id,example-ingestion-id
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-1ddb8d39074e033b7e3b9ad6aa6b5e6ed832715c988378a7207b9a6eba24f08c -->