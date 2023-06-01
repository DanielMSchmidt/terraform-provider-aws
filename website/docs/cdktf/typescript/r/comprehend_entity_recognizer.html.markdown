---
subcategory: "Comprehend"
layout: "aws"
page_title: "AWS: aws_comprehend_entity_recognizer"
description: |-
  Terraform resource for managing an AWS Comprehend Entity Recognizer.
---

# Resource: aws_comprehend_entity_recognizer

Terraform resource for managing an AWS Comprehend Entity Recognizer.

## Example Usage

### Basic Usage

```terraform
resource "aws_comprehend_entity_recognizer" "example" {
  name = "example"

  data_access_role_arn = aws_iam_role.example.arn

  language_code = "en"
  input_data_config {
    entity_types {
      type = "ENTITY_1"
    }
    entity_types {
      type = "ENTITY_2"
    }

    documents {
      s3_uri = "s3://${aws_s3_bucket.documents.bucket}/${aws_s3_object.documents.id}"
    }

    entity_list {
      s3_uri = "s3://${aws_s3_bucket.entities.bucket}/${aws_s3_object.entities.id}"
    }
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
* `name` - (Required) Name for the Entity Recognizer.
  Has a maximum length of 63 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).

The following arguments are optional:

* `modelKmsKeyId` - (Optional) The ID or ARN of a KMS Key used to encrypt trained Entity Recognizers.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` Configuration Block](/docs/providers/aws/index.html#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `versionName` - (Optional) Name for the version of the Entity Recognizer.
  Each version must have a unique name within the Entity Recognizer.
  If omitted, Terraform will assign a random, unique version name.
  If explicitly set to `""`, no version name will be set.
  Has a maximum length of 63 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionNamePrefix`.
* `versionNamePrefix` - (Optional) Creates a unique version name beginning with the specified prefix.
  Has a maximum length of 37 characters.
  Can contain upper- and lower-case letters, numbers, and hypen (`-`).
  Conflicts with `versionName`.
* `volumeKmsKeyId` - (Optional) ID or ARN of a KMS Key used to encrypt storage volumes during job processing.
* `vpcConfig` - (Optional) Configuration parameters for VPC to contain Entity Recognizer resources.
  See the [`vpcConfig` Configuration Block](#vpc_config-configuration-block) section below.

### `inputDataConfig` Configuration Block

* `annotations` - (Optional) Specifies location of the document annotation data.
  See the [`annotations` Configuration Block](#annotations-configuration-block) section below.
  One of `annotations` or `entityList` is required.
* `augmentedManifests` - (Optional) List of training datasets produced by Amazon SageMaker Ground Truth.
  Used if `dataFormat` is `augmentedManifest`.
  See the [`augmentedManifests` Configuration Block](#augmented_manifests-configuration-block) section below.
* `dataFormat` - (Optional, Default: `comprehendCsv`) The format for the training data.
  One of `comprehendCsv` or `augmentedManifest`.
* `documents` - (Optional) Specifies a collection of training documents.
  Used if `dataFormat` is `comprehendCsv`.
  See the [`documents` Configuration Block](#documents-configuration-block) section below.
* `entityList` - (Optional) Specifies location of the entity list data.
  See the [`entityList` Configuration Block](#entity_list-configuration-block) section below.
  One of `entityList` or `annotations` is required.
* `entityTypes` - (Required) Set of entity types to be recognized.
  Has a maximum of 25 items.
  See the [`entityTypes` Configuration Block](#entity_types-configuration-block) section below.

### `annotations` Configuration Block

* `s3Uri` - (Required) Location of training annotations.
* `testS3Uri` - (Optional) Location of test annotations.

### `augmentedManifests` Configuration Block

* `annotationDataS3Uri` - (Optional) Location of annotation files.
* `attributeNames` - (Required) The JSON attribute that contains the annotations for the training documents.
* `documentType` - (Optional, Default: `plainTextDocument`) Type of augmented manifest.
  One of `plainTextDocument` or `semiStructuredDocument`.
* `s3Uri` - (Required) Location of augmented manifest file.
* `sourceDocumentsS3Uri` - (Optional) Location of source PDF files.
* `split` - (Optional, Default: `train`) Purpose of data in augmented manifest.
  One of `train` or `test`.

### `documents` Configuration Block

* `inputFormat` - (Optional, Default: `oneDocPerLine`) Specifies how the input files should be processed.
  One of `oneDocPerLine` or `oneDocPerFile`.
* `s3Uri` - (Required) Location of training documents.
* `testS3Uri` - (Optional) Location of test documents.

### `entityList` Configuration Block

* `s3Uri` - (Required) Location of entity list.

### `entityTypes` Configuration Block

* `type` - (Required) An entity type to be matched by the Entity Recognizer.
  Cannot contain a newline (`\n`), carriage return (`\r`), or tab (`\t`).

### `vpcConfig` Configuration Block

* `securityGroupIds` - (Required) List of security group IDs.
* `subnets` - (Required) List of VPC subnets.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Entity Recognizer version.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](/docs/providers/aws/index.html#default_tags-configuration-block).

## Timeouts

`awsComprehendEntityRecognizer` provides the following [Timeouts](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts) configuration options:

* `create` - (Optional, Default: `60M`)
* `update` - (Optional, Default: `60M`)
* `delete` - (Optional, Default: `30M`)

## Import

Comprehend Entity Recognizer can be imported using the ARN, e.g.,

```
$ terraform import aws_comprehend_entity_recognizer.example arn:aws:comprehend:us-west-2:123456789012:entity-recognizer/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-0a8169a3a253139bfa45d4ece46337dd507bf492f93c68ed5930e4f47a091b6b -->