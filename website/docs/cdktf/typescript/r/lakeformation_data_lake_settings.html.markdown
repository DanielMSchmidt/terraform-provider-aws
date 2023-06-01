---
subcategory: "Lake Formation"
layout: "aws"
page_title: "AWS: aws_lakeformation_data_lake_settings"
description: |-
  Manages data lake administrators and default database and table permissions
---

# Resource: aws_lakeformation_data_lake_settings

Manages Lake Formation principals designated as data lake administrators and lists of principal permission entries for default create database and default create table permissions.

~> **NOTE:** Lake Formation introduces fine-grained access control for data in your data lake. Part of the changes include the `iamAllowedPrincipals` principal in order to make Lake Formation backwards compatible with existing IAM and Glue permissions. For more information, see [Changing the Default Security Settings for Your Data Lake](https://docs.aws.amazon.com/lake-formation/latest/dg/change-settings.html) and [Upgrading AWS Glue Data Permissions to the AWS Lake Formation Model](https://docs.aws.amazon.com/lake-formation/latest/dg/upgrade-glue-lake-formation.html).

## Example Usage

### Data Lake Admins

```terraform
resource "aws_lakeformation_data_lake_settings" "example" {
  admins = [aws_iam_user.test.arn, aws_iam_role.test.arn]
}
```

### Create Default Permissions

```terraform
resource "aws_lakeformation_data_lake_settings" "example" {
  admins = [aws_iam_user.test.arn, aws_iam_role.test.arn]

  create_database_default_permissions {
    permissions = ["SELECT", "ALTER", "DROP"]
    principal   = aws_iam_user.test.arn
  }

  create_table_default_permissions {
    permissions = ["ALL"]
    principal   = aws_iam_role.test.arn
  }
}
```

### Enable EMR access to LakeFormation resources

```terraform
resource "aws_lakeformation_data_lake_settings" "example" {
  admins = [aws_iam_user.test.arn, aws_iam_role.test.arn]

  create_database_default_permissions {
    permissions = ["SELECT", "ALTER", "DROP"]
    principal   = aws_iam_user.test.arn
  }

  create_table_default_permissions {
    permissions = ["ALL"]
    principal   = aws_iam_role.test.arn
  }

  allow_external_data_filtering      = true
  external_data_filtering_allow_list = [data.aws_caller_identity.current.account_id, data.aws_caller_identity.third_party.account_id]
  authorized_session_tag_value_list  = ["Amazon EMR"]
}
```

## Argument Reference

The following arguments are optional:

* `admins` – (Optional) Set of ARNs of AWS Lake Formation principals (IAM users or roles).
* `catalogId` – (Optional) Identifier for the Data Catalog. By default, the account ID.
* `createDatabaseDefaultPermissions` - (Optional) Up to three configuration blocks of principal permissions for default create database permissions. Detailed below.
* `createTableDefaultPermissions` - (Optional) Up to three configuration blocks of principal permissions for default create table permissions. Detailed below.
* `trustedResourceOwners` – (Optional) List of the resource-owning account IDs that the caller's account can use to share their user access details (user ARNs).
* `allowExternalDataFiltering` - (Optional) Whether to allow Amazon EMR clusters to access data managed by Lake Formation.
* `externalDataFilteringAllowList` - (Optional) A list of the account IDs of Amazon Web Services accounts with Amazon EMR clusters that are to perform data filtering.
* `authorizedSessionTagValueList` - (Optional) Lake Formation relies on a privileged process secured by Amazon EMR or the third party integrator to tag the user's role while assuming it.

~> **NOTE:** Although optional, not including `admins`, `createDatabaseDefaultPermissions`, `createTableDefaultPermissions`, and/or `trustedResourceOwners` results in the setting being cleared.

### create_database_default_permissions

The following arguments are optional:

* `permissions` - (Optional) List of permissions that are granted to the principal. Valid values may include `all`, `select`, `alter`, `drop`, `delete`, `insert`, `describe`, and `createTable`. For more details, see [Lake Formation Permissions Reference](https://docs.aws.amazon.com/lake-formation/latest/dg/lf-permissions-reference.html).
* `principal` - (Optional) Principal who is granted permissions. To enforce metadata and underlying data access control only by IAM on new databases and tables set `principal` to `iamAllowedPrincipals` and `permissions` to `["all"]`.

### create_table_default_permissions

The following arguments are optional:

* `permissions` - (Optional) List of permissions that are granted to the principal. Valid values may include `all`, `select`, `alter`, `drop`, `delete`, `insert`, and `describe`. For more details, see [Lake Formation Permissions Reference](https://docs.aws.amazon.com/lake-formation/latest/dg/lf-permissions-reference.html).
* `principal` - (Optional) Principal who is granted permissions. To enforce metadata and underlying data access control only by IAM on new databases and tables set `principal` to `iamAllowedPrincipals` and `permissions` to `["all"]`.

## Attributes Reference

No additional attributes are exported.

<!-- cache-key: cdktf-0.17.0-pre.15 input-4d6a825e613e0bf96009f6d3b4fcfd8b8d7ee62b0fd067b934b66edc2c908546 -->