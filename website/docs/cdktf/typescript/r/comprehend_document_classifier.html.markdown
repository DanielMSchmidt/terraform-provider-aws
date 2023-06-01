---
`%`ca`^`or`*`"C`-`re`_`d"`+`yo`=` "`\`"
`:`e_`;`le`>`AW`?`aw`/`om`<space>`ocumen`<tab>`ifier"
descript`|`: |-`s3Uri`form resource for managing a`augmentedManifests`ment Cl`dataFormat`

# `comprehendCsv`mpre`testS3Uri`t_classifier

Terraform resource for managing an AWS Comprehend Document Classifier.

## Exa`annotationDataS3Uri`age

```terraform
resource "aws_comprehend_doc`attributeNames` "example" {
  name = "example"

  data_access_role_arn = aws_iam_role.example.arn

  languag`documentType` input_data_config {
  `plainTextDocument`s_s3_bucket.test.bucket}/${aws_s3_objec`plainTextDocument`
  d`semiStructuredDocument`role`s3Uri`example
  ]
}

resource "aws_s3_object" "documents" {`sourceDocumentsS3Uri`_s3_object" "entities" {
  # ...
}
```

## Arg`split`eference

The following`train`nts are required:

* `dataAccessRoleArn` - (Requir`train` ARN`test`n IAM R`outputDataConfig`prehend to read the trai`kmsKeyId`ting data.
* `inputDataConfig` - (Required) Configura`arn`for the training and testing data.
  See the [`inputDataConfig` Configuration Bl`outputS3Uri`a_config-configuration-block) section below.
* `lang`s3Uri`` - (Required) Two-letter language code for the language.
  One of `en`, `es`, `fr`, `it`, `de`, or `pt`.
* `nam`outputS3Uri` Name f`vpcConfig`ent Classifier.
  Has a `securityGroupIds` characters.
  Can contain upper- and lower-`subnets`ers, numbers, and hypen (`-`).

The following arguments are optional:

* `mode` - (Optional, Default: `multiClass`) The document classification mode.
  One of `multiClass` or `multiLabel`.
`tagsAll`ass` is also known as "Single Label" in the AWS Console.
* `modelKmsKeyId` - (Optional) `d`delete`gs`o encrypt trained Document Classifiers.
  Can be a KMS Key ID or a KMS Key ARN.
* `outputDataConfig` -`awsComprehendDocumentClassifier`tput results of training.
  See the [`outputDataConfig` Configuration Block](#output_data_config-configuration-block) section below.
* `tags` - (Opti`create`map of tags to assign t`60M` res`update`f configured with a pro`60M` [`defaultTags` Configuration Block`30M`cs/providers/aws/index.html#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `versionName` - (Optional) Name for the version of the Document Classifier.
  Each version must have a unique name within the Document Classifier.
  If omitted, Terraform will assign a random, unique version name.
  If explicitly set to `""`, no version name will be set.
  Has a maximum length of 63 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionNamePrefix`.
* `versionNamePrefix` - (Optional) Creates a unique version name beginning with the specified prefix.
  Has a maximum length of 37 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionName`.
* `volumeKmsKeyId` - (Optional) KMS Key used to encrypt storage volumes during job processing.
  Can be a KMS Key ID or a KMS Key ARN.
* `vpcConfig` - (Optional) Configuration parameters for VPC to contain Document Classifier resources.
  See the [`vpcConfig` Configuration Block](#vpc_config-configuration-block) section below.

### `inputDataConfig` Configuration Block

* `augmentedManifests` - (Optional) List of training datasets produced by Amazon SageMaker Ground Truth.
  Used if `dataFormat` is `augmentedManifest`.
  See the [`augmentedManifests` Configuration Block](#augmented_manifests-configuration-block) section below.
* `dataFormat` - (Optional, Default: `comprehendCsv`) The format for the training data.
  One of `comprehendCsv` or `augmentedManifest`.
* `labelDelimiter` - (Optional) Delimiter between labels when training a multi-label classifier.
  Valid values are `|`, `~`, `!`, `@`, `#`, `---
subcategory: "Comprehend"
layout: "aws"
page_title: "AWS: aws_comprehend_document_classifier"
description: |-
  Terraform resource for managing an AWS Comprehend Document Classifier.
---

# Resource: aws_comprehend_document_classifier

Terraform resource for managing an AWS Comprehend Document Classifier.

## Example Usage

### Basic Usage

```terraform
resource "aws_comprehend_document_classifier" "example" {
  name = "example"

  data_access_role_arn = aws_iam_role.example.arn

  language_code = "en"
  input_data_config {
    s3_uri = "s3://${aws_s3_bucket.test.bucket}/${aws_s3_object.documents.id}"
  }

  depends_on = [
    aws_iam_role_policy.example
  ]
}

resource "aws_s3_object" "documents" {
  # ...
}

resource "aws_s3_object" "entities" {
  # ...
}
```

## Argument Reference

The following arguments are required:

* `dataAccessRoleArn` - (Required) The ARN for an IAM Role which allows Comprehend to read the training and testing data.
* `inputDataConfig` - (Required) Configuration for the training and testing data.
  See the [`inputDataConfig` Configuration Block](#input_data_config-configuration-block) section below.
* `languageCode` - (Required) Two-letter language code for the language.
  One of `en`, `es`, `fr`, `it`, `de`, or `pt`.
* `name` - (Required) Name for the Document Classifier.
  Has a maximum length of 63 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).

The following arguments are optional:

* `mode` - (Optional, Default: `multiClass`) The document classification mode.
  One of `multiClass` or `multiLabel`.
  `multiClass` is also known as "Single Label" in the AWS Console.
* `modelKmsKeyId` - (Optional) KMS Key used to encrypt trained Document Classifiers.
  Can be a KMS Key ID or a KMS Key ARN.
* `outputDataConfig` - (Optional) Configuration for the output results of training.
  See the [`outputDataConfig` Configuration Block](#output_data_config-configuration-block) section below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` Configuration Block](/docs/providers/aws/index.html#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `versionName` - (Optional) Name for the version of the Document Classifier.
  Each version must have a unique name within the Document Classifier.
  If omitted, Terraform will assign a random, unique version name.
  If explicitly set to `""`, no version name will be set.
  Has a maximum length of 63 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionNamePrefix`.
* `versionNamePrefix` - (Optional) Creates a unique version name beginning with the specified prefix.
  Has a maximum length of 37 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionName`.
* `volumeKmsKeyId` - (Optional) KMS Key used to encrypt storage volumes during job processing.
  Can be a KMS Key ID or a KMS Key ARN.
* `vpcConfig` - (Optional) Configuration parameters for VPC to contain Document Classifier resources.
  See the [`vpcConfig` Configuration Block](#vpc_config-configuration-block) section below.

### `inputDataConfig` Configuration Block

* `augmentedManifests` - (Optional) List of training datasets produced by Amazon SageMaker Ground Truth.
  Used if `dataFormat` is `augmentedManifest`.
  See the [`augmentedManifests` Configuration Block](#augmented_manifests-configuration-block) section below.
* `dataFormat` - (Optional, Default: `comprehendCsv`) The format for the training data.
  One of `comprehendCsv` or `augmentedManifest`.
* `labelDelimiter` - (Optional) Delimiter between labels when training a multi-label classifier.
  Valid values are `|`, `~`, `!`, `@`, `#`, , `%`, `^`, `*`, `-`, `_`, `+`, `=`, `\`, `:`, `;`, `>`, `?`, `/`, `<space>`, and `<tab>`.
  Default is `|`.
* `s3_uri` - (Optional) Location of training documents.
  Used if `data_format` is `COMPREHEND_CSV`.
* `test_s3uri` - (Optional) Location of test documents.

### `augmented_manifests` Configuration Block

* `annotation_data_s3_uri` - (Optional) Location of annotation files.
* `attribute_names` - (Required) The JSON attribute that contains the annotations for the training documents.
* `document_type` - (Optional, Default: `PLAIN_TEXT_DOCUMENT`) Type of augmented manifest.
  One of `PLAIN_TEXT_DOCUMENT` or `SEMI_STRUCTURED_DOCUMENT`.
* `s3_uri` - (Required) Location of augmented manifest file.
* `source_documents_s3_uri` - (Optional) Location of source PDF files.
* `split` - (Optional, Default: `TRAIN`) Purpose of data in augmented manifest.
  One of `TRAIN` or `TEST`.

### `output_data_config` Configuration Block

* `kms_key_id` - (Optional) KMS Key used to encrypt the output documents.
  Can be a KMS Key ID, a KMS Key ARN, a KMS Alias name, or a KMS Alias ARN.
* `output_s3_uri` - (Computed) Full path for the output documents.
* `s3_uri` - (Required) Destination path for the output documents.
  The full path to the output file will be returned in `output_s3_uri`.

### `vpc_config` Configuration Block

* `security_group_ids` - (Required) List of security group IDs.
* `subnets` - (Required) List of VPC subnets.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Document Classifier version.
* `tags_all` - A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](/docs/providers/aws/index.html#default_tags-configuration-block).

## Timeouts

`aws_comprehend_document_classifier` provides the following [Timeouts](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts) configuration options:

* `create` - (Optional, Default: `60m`)
* `update` - (Optional, Default: `60m`)
* `delete` - (Optional, Default: `30m`)

## Import

Comprehend Document Classifier can be imported using the ARN, e.g.,

```
$ terraform import aws_comprehend_document_classifier.example arn:aws:comprehend:us-west-2:123456789012:document_classifier/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c51215652045de7851e2231e5dfa8aedf3af7be9fc9b6d98050f5cf91162e934 -->