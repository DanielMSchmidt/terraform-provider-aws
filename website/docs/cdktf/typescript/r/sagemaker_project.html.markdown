---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_project"
description: |-
  Provides a SageMaker Project resource.
---

# Resource: aws_sagemaker_project

Provides a SageMaker Project resource.

 -> Note: If you are trying to use SageMaker projects with SageMaker studio you will need to add a tag with the key `sagemaker:studioVisibility` with value `true`. For more on requirements to use projects and permission needed see [AWS Docs](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-projects-templates-custom.html).

## Example Usage

```terraform
resource "aws_sagemaker_project" "example" {
  project_name = "example"

  service_catalog_provisioning_details {
    product_id = aws_servicecatalog_product.example.id
  }
}
```

## Argument Reference

The following arguments are supported:

* `projectName` - (Required) The name of the Project.
* `projectDescription` - (Optional) A description for the project.
* `serviceCatalogProvisioningDetails` - (Required) The product ID and provisioning artifact ID to provision a service catalog. See [Service Catalog Provisioning Details](#service-catalog-provisioning-details) below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Service Catalog Provisioning Details

* `pathId` - (Optional) The path identifier of the product. This value is optional if the product has a default path, and required if the product has more than one path.
* `productId` - (Required) The ID of the product to provision.
* `provisioningArtifactId` - (Optional) The ID of the provisioning artifact.
* `provisioningParameter` - (Optional) A list of key value pairs that you specify when you provision a product. See [Provisioning Parameter](#provisioning-parameter) below.

#### Provisioning Parameter

* `key` - (Required) The key that identifies a provisioning parameter.
* `value` - (Optional) The value of the provisioning parameter.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Project.
* `id` - The name of the Project.
* `projectId` - The ID of the project.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

SageMaker Projects can be imported using the `projectName`, e.g.,

```
$ terraform import aws_sagemaker_project.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-34ae2d2a3f04213a25c4f8d6d074f7d983669f39dd8c752500fe53f01e036fcf -->