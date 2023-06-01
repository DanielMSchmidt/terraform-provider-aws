---
subcategory: "Organizations"
layout: "aws"
page_title: "AWS: aws_organizations_delegated_services"
description: |-
  Get a list the AWS services for which the specified account is a delegated administrator 
---

# Data Source: aws_organizations_delegated_services

Get a list the AWS services for which the specified account is a delegated administrator

## Example Usage

```terraform
data "aws_organizations_delegated_services" "example" {
  account_id = "AWS ACCOUNT ID"
}
```

## Argument Reference

* `accountId` - (Required) Account ID number of a delegated administrator account in the organization.

## Attributes Reference

* `delegatedServices` - Services for which the account is a delegated administrator, which have the following attributes:
    * `delegationEnabledDate` - The date that the account became a delegated administrator for this service.
    * `servicePrincipal` - The name of an AWS service that can request an operation for the specified service.

<!-- cache-key: cdktf-0.17.0-pre.15 input-8615c43f77ff9b1db6e14600c2225c7b5d0a1ad2a779366a01f40eb45a4fc36f -->