---
subcategory: "Kendra"
layout: "aws"
page_title: "AWS: aws_kendra_index"
description: |-
  Provides an Amazon Kendra Index resource.
---

# Resource: aws_kendra_index

Provides an Amazon Kendra Index resource.

## Example Usage

### Basic

```terraform
resource "aws_kendra_index" "example" {
  name        = "example"
  description = "example"
  edition     = "DEVELOPER_EDITION"
  role_arn    = aws_iam_role.this.arn

  tags = {
    "Key1" = "Value1"
  }
}
```

### With capacity units

```terraform
resource "aws_kendra_index" "example" {
  name     = "example"
  edition  = "DEVELOPER_EDITION"
  role_arn = aws_iam_role.this.arn

  capacity_units {
    query_capacity_units   = 2
    storage_capacity_units = 2
  }
}
```

### With server side encryption configuration

```terraform
resource "aws_kendra_index" "example" {
  name     = "example"
  role_arn = aws_iam_role.this.arn

  server_side_encryption_configuration {
    kms_key_id = data.aws_kms_key.this.arn
  }
}
```

### With Document Metadata Configuration Updates

#### Specifying the predefined elements

```terraform
resource "aws_kendra_index" "example" {
  name     = "example"
  role_arn = aws_iam_role.this.arn

  document_metadata_configuration_updates {
    name = "_authors"
    type = "STRING_LIST_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance = 1
    }
  }

  document_metadata_configuration_updates {
    name = "_category"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_created_at"
    type = "DATE_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      freshness  = false
      importance = 1
      duration   = "25920000s"
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_data_source_id"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_document_title"
    type = "STRING_VALUE"
    search {
      displayable = true
      facetable   = false
      searchable  = true
      sortable    = true
    }
    relevance {
      importance            = 2
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_excerpt_page_number"
    type = "LONG_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance = 2
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_faq_id"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_file_type"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_language_code"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_last_updated_at"
    type = "DATE_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      freshness  = false
      importance = 1
      duration   = "25920000s"
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_source_uri"
    type = "STRING_VALUE"
    search {
      displayable = true
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_version"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_view_count"
    type = "LONG_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance = 1
      rank_order = "ASCENDING"
    }
  }
}
```

#### Appending additional elements

The example below shows additional elements with names, `exampleStringValue`, `exampleLongValue`, `exampleStringListValue`, `exampleDateValue` representing the 4 types of `stringValue`, `longValue`, `stringListValue`, `dateValue` respectively.

```terraform
resource "aws_kendra_index" "example" {
  name     = "example"
  role_arn = aws_iam_role.this.arn

  document_metadata_configuration_updates {
    name = "_authors"
    type = "STRING_LIST_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance = 1
    }
  }

  document_metadata_configuration_updates {
    name = "_category"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_created_at"
    type = "DATE_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      freshness  = false
      importance = 1
      duration   = "25920000s"
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_data_source_id"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_document_title"
    type = "STRING_VALUE"
    search {
      displayable = true
      facetable   = false
      searchable  = true
      sortable    = true
    }
    relevance {
      importance            = 2
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_excerpt_page_number"
    type = "LONG_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance = 2
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_faq_id"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_file_type"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_language_code"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_last_updated_at"
    type = "DATE_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      freshness  = false
      importance = 1
      duration   = "25920000s"
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "_source_uri"
    type = "STRING_VALUE"
    search {
      displayable = true
      facetable   = false
      searchable  = false
      sortable    = false
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_version"
    type = "STRING_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "_view_count"
    type = "LONG_VALUE"
    search {
      displayable = false
      facetable   = false
      searchable  = false
      sortable    = true
    }
    relevance {
      importance = 1
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "example-string-value"
    type = "STRING_VALUE"
    search {
      displayable = true
      facetable   = true
      searchable  = true
      sortable    = true
    }
    relevance {
      importance            = 1
      values_importance_map = {}
    }
  }

  document_metadata_configuration_updates {
    name = "example-long-value"
    type = "LONG_VALUE"
    search {
      displayable = true
      facetable   = true
      searchable  = false
      sortable    = true
    }
    relevance {
      importance = 1
      rank_order = "ASCENDING"
    }
  }

  document_metadata_configuration_updates {
    name = "example-string-list-value"
    type = "STRING_LIST_VALUE"
    search {
      displayable = true
      facetable   = true
      searchable  = true
      sortable    = false
    }
    relevance {
      importance = 1
    }
  }

  document_metadata_configuration_updates {
    name = "example-date-value"
    type = "DATE_VALUE"
    search {
      displayable = true
      facetable   = true
      searchable  = false
      sortable    = false
    }
    relevance {
      freshness  = false
      importance = 1
      duration   = "25920000s"
      rank_order = "ASCENDING"
    }
  }
}
```

### With JSON token type configuration

```terraform
resource "aws_kendra_index" "example" {
  name     = "example"
  role_arn = aws_iam_role.this.arn

  user_token_configurations {
    json_token_type_configuration {
      group_attribute_field     = "groups"
      user_name_attribute_field = "username"
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `capacityUnits` - (Optional) A block that sets the number of additional document storage and query capacity units that should be used by the index. [Detailed below](#capacity_units).
* `description` - (Optional) The description of the Index.
* `documentMetadataConfigurationUpdates` - (Optional) One or more blocks that specify the configuration settings for any metadata applied to the documents in the index. Minimum number of 0 items. Maximum number of 500 items. If specified, you must define all elements, including those that are provided by default. These index fields are documented at [Amazon Kendra Index documentation](https://docs.aws.amazon.com/kendra/latest/dg/hiw-index.html). For an example resource that defines these default index fields, refer to the [default example above](#specifying-the-predefined-elements). For an example resource that appends additional index fields, refer to the [append example above](#appending-additional-elements). All arguments for each block must be specified. Note that blocks cannot be removed since index fields cannot be deleted. This argument is [detailed below](#document_metadata_configuration_updates).
* `edition` - (Optional) The Amazon Kendra edition to use for the index. Choose `developerEdition` for indexes intended for development, testing, or proof of concept. Use `enterpriseEdition` for your production databases. Once you set the edition for an index, it can't be changed. Defaults to `enterpriseEdition`
* `name` - (Required) Specifies the name of the Index.
* `roleArn` - (Required) An AWS Identity and Access Management (IAM) role that gives Amazon Kendra permissions to access your Amazon CloudWatch logs and metrics. This is also the role you use when you call the `batchPutDocument` API to index documents from an Amazon S3 bucket.
* `serverSideEncryptionConfiguration` - (Optional) A block that specifies the identifier of the AWS KMS customer managed key (CMK) that's used to encrypt data indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric CMKs. [Detailed below](#server_side_encryption_configuration).
* `userContextPolicy` - (Optional) The user context policy. Valid values are `attributeFilter` or `userToken`. For more information, refer to [UserContextPolicy](https://docs.aws.amazon.com/kendra/latest/APIReference/API_CreateIndex.html#kendra-CreateIndex-request-UserContextPolicy). Defaults to `attributeFilter`.
* `userGroupResolutionConfiguration` - (Optional) A block that enables fetching access levels of groups and users from an AWS Single Sign-On identity source. To configure this, see [UserGroupResolutionConfiguration](https://docs.aws.amazon.com/kendra/latest/dg/API_UserGroupResolutionConfiguration.html). [Detailed below](#user_group_resolution_configuration).
* `userTokenConfigurations` - (Optional) A block that specifies the user token configuration. [Detailed below](#user_token_configurations).
* `tags` - (Optional) Tags to apply to the Index. If configured with a provider
[`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### `capacityUnits`

A `capacityUnits` block supports the following arguments:

* `queryCapacityUnits` - (Required) The amount of extra query capacity for an index and GetQuerySuggestions capacity. For more information, refer to [QueryCapacityUnits](https://docs.aws.amazon.com/kendra/latest/dg/API_CapacityUnitsConfiguration.html#Kendra-Type-CapacityUnitsConfiguration-QueryCapacityUnits).
* `storageCapacityUnits` - (Required) The amount of extra storage capacity for an index. A single capacity unit provides 30 GB of storage space or 100,000 documents, whichever is reached first. Minimum value of 0.

### `documentMetadataConfigurationUpdates`

A `documentMetadataConfigurationUpdates` block supports the following arguments:

* `name` - (Required) The name of the index field. Minimum length of 1. Maximum length of 30.
* `relevance` - (Required) A block that provides manual tuning parameters to determine how the field affects the search results. [Detailed below](#relevance)
* `search` - (Required) A block that provides information about how the field is used during a search. Documented below. [Detailed below](#search)
* `type` - (Required) The data type of the index field. Valid values are `stringValue`, `stringListValue`, `longValue`, `dateValue`.

#### `relevance`

A `relevance` block supports the following attributes:

* `duration` - (Required if type is of `dateValue`) Specifies the time period that the boost applies to. For more information, refer to [Duration](https://docs.aws.amazon.com/kendra/latest/dg/API_Relevance.html#Kendra-Type-Relevance-Duration).
* `freshness` - (Required if type is of `dateValue`) Indicates that this field determines how "fresh" a document is. For more information, refer to [Freshness](https://docs.aws.amazon.com/kendra/latest/dg/API_Relevance.html#Kendra-Type-Relevance-Freshness).
* `importance` - (Required for all types) The relative importance of the field in the search. Larger numbers provide more of a boost than smaller numbers. Minimum value of 1. Maximum value of 10.
* `rankOrder` - (Required if type is of `dateValue`, or `longValue`) Determines how values should be interpreted. For more information, refer to [RankOrder](https://docs.aws.amazon.com/kendra/latest/dg/API_Relevance.html#Kendra-Type-Relevance-RankOrder).
* `valuesImportanceMap` - (Required if type is of `stringValue`) A list of values that should be given a different boost when they appear in the result list. For more information, refer to [ValueImportanceMap](https://docs.aws.amazon.com/kendra/latest/dg/API_Relevance.html#Kendra-Type-Relevance-ValueImportanceMap).

#### `search`

A `search` block supports the following attributes:

* `displayable` - (Required) Determines whether the field is returned in the query response. The default is `true`.
* `facetable` - (Required) Indicates that the field can be used to create search facets, a count of results for each value in the field. The default is `false`.
* `searchable` - (Required) Determines whether the field is used in the search. If the Searchable field is true, you can use relevance tuning to manually tune how Amazon Kendra weights the field in the search. The default is `true` for `string` fields and `false` for `number` and `date` fields.
* `sortable` - (Required) Determines whether the field can be used to sort the results of a query. If you specify sorting on a field that does not have Sortable set to true, Amazon Kendra returns an exception. The default is `false`.

### `serverSideEncryptionConfiguration`

A `serverSideEncryptionConfiguration` block supports the following arguments:

* `kmsKeyId` - (Optional) The identifier of the AWS KMScustomer master key (CMK). Amazon Kendra doesn't support asymmetric CMKs.

### `userGroupResolutionConfiguration`

A `userGroupResolutionConfiguration` block supports the following arguments:

* `userGroupResolutionMode` - (Required) The identity store provider (mode) you want to use to fetch access levels of groups and users. AWS Single Sign-On is currently the only available mode. Your users and groups must exist in an AWS SSO identity source in order to use this mode. Valid Values are `awsSso` or `none`.

### `userTokenConfigurations`

A `userTokenConfigurations` block supports the following arguments:

* `jsonTokenTypeConfiguration` - (Optional) A block that specifies the information about the JSON token type configuration. [Detailed below](#json_token_type_configuration).
* `jwtTokenTypeConfiguration` - (Optional) A block that specifies the information about the JWT token type configuration. [Detailed below](#jwt_token_type_configuration).

#### `jsonTokenTypeConfiguration`

A `jsonTokenTypeConfiguration` block supports the following arguments:

* `groupAttributeField` - (Required) The group attribute field. Minimum length of 1. Maximum length of 2048.
* `userNameAttributeField` - (Required) The user name attribute field. Minimum length of 1. Maximum length of 2048.

#### `jwtTokenTypeConfiguration`

A `jwtTokenTypeConfiguration` block supports the following arguments:

* `claimRegex` - (Optional) The regular expression that identifies the claim. Minimum length of 1. Maximum length of 100.
* `groupAttributeField` - (Optional) The group attribute field. Minimum length of 1. Maximum length of 100.
* `issuer` - (Optional) The issuer of the token. Minimum length of 1. Maximum length of 65.
* `keyLocation` - (Required) The location of the key. Valid values are `url` or `secretManager`
* `secretsManagerArn` - (Optional) The Amazon Resource Name (ARN) of the secret.
* `url` - (Optional) The signing key URL. Valid pattern is `^(https?|ftp|file):\/\/([^\s]*)`
* `userNameAttributeField` - (Optional) The user name attribute field. Minimum length of 1. Maximum length of 100.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `40M`)
* `delete` - (Default `40M`)
* `update` - (Default `40M`)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) of the Index.
* `createdAt` - The Unix datetime that the index was created.
* `errorMessage` - When the Status field value is `failed`, this contains a message that explains why.
* `id` - The identifier of the Index.
* `indexStatistics` - A block that provides information about the number of FAQ questions and answers and the number of text documents indexed. [Detailed below](#index_statistics).
* `status` - The current status of the index. When the value is `active`, the index is ready for use. If the Status field value is `failed`, the `errorMessage` field contains a message that explains why.
* `updatedAt` - The Unix datetime that the index was last updated.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

### `indexStatistics`

A `indexStatistics` block supports the following attributes:

* `faqStatistics` - A block that specifies the number of question and answer topics in the index. [Detailed below](#faq_statistics).
* `textDocumentStatistics` - A block that specifies the number of text documents indexed. [Detailed below](#text_document_statistics).

#### `faqStatistics`

A `faqStatistics` block supports the following attributes:

* `indexedQuestionAnswersCount` - The total number of FAQ questions and answers contained in the index.

#### `textDocumentStatistics`

A `textDocumentStatistics` block supports the following attributes:

* `indexedTextBytes` - The total size, in bytes, of the indexed documents.
* `indexedTextDocumentsCount` - The number of text documents indexed.

## Import

Amazon Kendra Indexes can be imported using its `id`, e.g.,

```
$ terraform import aws_kendra_index.example 12345678-1234-5678-9123-123456789123
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b1aa21353944bdbbbd7bb19e9a4c7b6b243be5091af5b8b38f68239c7df7f671 -->