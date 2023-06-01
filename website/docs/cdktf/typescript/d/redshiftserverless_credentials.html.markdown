---
subcategory: "Redshift Serverless"
layout: "aws"
page_title: "AWS: aws_redshiftserverless_credentials"
description: |-
  Provides redshift serverless credentials
---

# Data Source: aws_redshiftserverless_credentials

Provides redshift serverless temporary credentials for a workgroup.

## Example Usage

```terraform
data "aws_redshiftserverless_credentials" "example" {
  workgroup_name = aws_redshiftserverless_workgroup.example.workgroup_name
}
```

## Argument Reference

The following arguments are supported:

* `workgroupName` - (Required) The name of the workgroup associated with the database.
* `dbName` - (Optional) The name of the database to get temporary authorization to log on to.
* `durationSeconds` - (Optional) The number of seconds until the returned temporary password expires. The minimum is 900 seconds, and the maximum is 3600 seconds.

## Attribute Reference

In addition to all arguments above, the following attributes are exported:

* `dbPassword` - Temporary password that authorizes the user name returned by `dbUser` to log on to the database `dbName`.
* `dbUser` - A database user name that is authorized to log on to the database `dbName` using the password `dbPassword` . If the specified `dbUser` exists in the database, the new user name has the same database privileges as the user named in `dbUser` . By default, the user is added to PUBLIC. the user doesn't exist in the database.
* `expiration` - Date and time the password in `dbPassword` expires.

<!-- cache-key: cdktf-0.17.0-pre.15 input-53e6ac57303a0c2e14fa7b964e83652062a767057c3d94e6643fae3f2ebbd7b7 -->