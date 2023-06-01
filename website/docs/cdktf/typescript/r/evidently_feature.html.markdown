---
subcategory: "CloudWatch Evidently"
layout: "aws"
page_title: "AWS: aws_evidently_feature"
description: |-
  Provides a CloudWatch Evidently Feature resource.
---

# Resource: aws_evidently_feature

Provides a CloudWatch Evidently Feature resource.

## Example Usage

### Basic

```terraform
resource "aws_evidently_feature" "example" {
  name        = "example"
  project     = aws_evidently_project.example.name
  description = "example description"

  variations {
    name = "Variation1"
    value {
      string_value = "example"
    }
  }

  tags = {
    "Key1" = "example Feature"
  }
}
```

### With default variation

```terraform
resource "aws_evidently_feature" "example" {
  name              = "example"
  project           = aws_evidently_project.example.name
  default_variation = "Variation2"

  variations {
    name = "Variation1"
    value {
      string_value = "exampleval1"
    }
  }

  variations {
    name = "Variation2"
    value {
      string_value = "exampleval2"
    }
  }
}
```

### With entity overrides

```terraform
resource "aws_evidently_feature" "example" {
  name    = "example"
  project = aws_evidently_project.example.name

  entity_overrides = {
    test1 = "Variation1"
  }

  variations {
    name = "Variation1"
    value {
      string_value = "exampleval1"
    }
  }

  variations {
    name = "Variation2"
    value {
      string_value = "exampleval2"
    }
  }
}
```

### With evaluation strategy

```terraform
resource "aws_evidently_feature" "example" {
  name                = "example"
  project             = aws_evidently_project.example.name
  evaluation_strategy = "ALL_RULES"

  entity_overrides = {
    test1 = "Variation1"
  }

  variations {
    name = "Variation1"
    value {
      string_value = "exampleval1"
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `defaultVariation` - (Optional) The name of the variation to use as the default variation. The default variation is served to users who are not allocated to any ongoing launches or experiments of this feature. This variation must also be listed in the `variations` structure. If you omit `defaultVariation`, the first variation listed in the `variations` structure is used as the default variation.
* `description` - (Optional) Specifies the description of the feature.
* `entityOverrides` - (Optional) Specify users that should always be served a specific variation of a feature. Each user is specified by a key-value pair . For each key, specify a user by entering their user ID, account ID, or some other identifier. For the value, specify the name of the variation that they are to be served.
* `evaluationStrategy` - (Optional) Specify `allRules` to activate the traffic allocation specified by any ongoing launches or experiments. Specify `defaultVariation` to serve the default variation to all users instead.
* `name` - (Required) The name for the new feature. Minimum length of `1`. Maximum length of `127`.
* `project` - (Required) The name or ARN of the project that is to contain the new feature.
* `tags` - (Optional) Tags to apply to the feature. If configured with a provider [`defaultTags` configuration block](/docs/providers/aws/index.html#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `variations` - (Required) One or more blocks that contain the configuration of the feature's different variations. [Detailed below](#variations)

### `variations`

The `variations` block supports the following arguments:

* `name` - (Required) The name of the variation. Minimum length of `1`. Maximum length of `127`.
* `value` - (Required) A block that specifies the value assigned to this variation. [Detailed below](#value)

#### `value`

The `value` block supports the following arguments:

~> **NOTE:** You must specify exactly one of `boolValue`, `doubleValue`, `longValue`, `stringValue`.

* `boolValue` - (Optional) If this feature uses the Boolean variation type, this field contains the Boolean value of this variation.
* `doubleValue` - (Optional) If this feature uses the double integer variation type, this field contains the double integer value of this variation.
* `longValue` - (Optional) If this feature uses the long variation type, this field contains the long value of this variation. Minimum value of `9007199254740991`. Maximum value of `9007199254740991`.
* `stringValue` - (Optional) If this feature uses the string variation type, this field contains the string value of this variation. Minimum length of `0`. Maximum length of `512`.

## Timeouts

[Configuration options](https://www.terraform.io/docs/configuration/blocks/resources/syntax.html#operation-timeouts):

* `create` - (Default `2M`)
* `delete` - (Default `2M`)
* `update` - (Default `2M`)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the feature.
* `createdTime` - The date and time that the feature is created.
* `evaluationRules` - One or more blocks that define the evaluation rules for the feature. [Detailed below](#evaluation_rules)
* `id` - The feature `name` and the project `name` or `arn` separated by a colon (`:`).
* `lastUpdatedTime` - The date and time that the feature was most recently updated.
* `status` - The current state of the feature. Valid values are `available` and `updating`.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](/docs/providers/aws/index.html#default_tags-configuration-block).
* `valueType` - Defines the type of value used to define the different feature variations. Valid Values: `string`, `long`, `double`, `boolean`.

### `evaluationRules`

The `evaluationRules` block supports the following attributes:

* `name` - The name of the experiment or launch.
* `type` - This value is `awsEvidentlySplits` if this is an evaluation rule for a launch, and it is `awsEvidentlyOnlineab` if this is an evaluation rule for an experiment.

## Import

CloudWatch Evidently Feature can be imported using the feature `name` and `name` or `arn` of the hosting CloudWatch Evidently Project separated by a `:`, e.g.,

```
$ terraform import aws_evidently_feature.example exampleFeatureName:arn:aws:evidently:us-east-1:123456789012:project/example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-b19d54c10981e356d14c0238c727e75f0a5aa72d1e8abcbca88051721d69173d -->