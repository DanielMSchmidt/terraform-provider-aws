---
subcategory: "EC2 Image Builder"
layout: "aws"
page_title: "AWS: aws_imagebuilder_image"
description: |-
    Manages an Image Builder Image
---

# Resource: aws_imagebuilder_image

Manages an Image Builder Image.

## Example Usage

```terraform
resource "aws_imagebuilder_image" "example" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.example.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.example.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.example.arn
}
```

## Argument Reference

The following arguments are required:

* `infrastructureConfigurationArn` - (Required) Amazon Resource Name (ARN) of the Image Builder Infrastructure Configuration.

The following arguments are optional:

* `containerRecipeArn` - (Optional) - Amazon Resource Name (ARN) of the container recipe.
* `distributionConfigurationArn` - (Optional) Amazon Resource Name (ARN) of the Image Builder Distribution Configuration.
* `enhancedImageMetadataEnabled` - (Optional) Whether additional information about the image being created is collected. Defaults to `true`.
* `imageRecipeArn` - (Optional) Amazon Resource Name (ARN) of the image recipe.
* `imageTestsConfiguration` - (Optional) Configuration block with image tests configuration. Detailed below.
* `tags` - (Optional) Key-value map of resource tags for the Image Builder Image. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### image_tests_configuration

The following arguments are optional:

* `imageTestsEnabled` - (Optional) Whether image tests are enabled. Defaults to `true`.
* `timeoutMinutes` - (Optional) Number of minutes before image tests time out. Valid values are between `60` and `1440`. Defaults to `720`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the image.
* `dateCreated` - Date the image was created.
* `platform` - Platform of the image.
* `osVersion` - Operating System version of the image.
* `outputResources` - List of objects with resources created by the image.
    * `amis` - Set of objects with each Amazon Machine Image (AMI) created.
        * `accountId` - Account identifier of the AMI.
        * `description` - Description of the AMI.
        * `image` - Identifier of the AMI.
        * `name` - Name of the AMI.
        * `region` - Region of the AMI.
    * `containers` - Set of objects with each container image created and stored in the output repository.
        * `imageUris` - Set of URIs for created containers.
        * `region` - Region of the container image.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `version` - Version of the image.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `60M`)

## Import

`awsImagebuilderImage` resources can be imported using the Amazon Resource Name (ARN), e.g.,

```
$ terraform import aws_imagebuilder_image.example arn:aws:imagebuilder:us-east-1:123456789012:image/example/1.0.0/1
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-cb3437ba87975a46e1ff5b30f2885937a1fbca2d4d50090b797a3dcf1794c6ac -->