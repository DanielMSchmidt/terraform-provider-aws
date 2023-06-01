---
subcategory: "App Runner"
layout: "aws"
page_title: "AWS: aws_apprunner_vpc_ingress_connection"
description: |-
  Manages an App Runner VPC Ingress Connection.
---

# Resource: aws_apprunner_vpc_ingress_connection

Manages an App Runner VPC Ingress Connection.

## Example Usage

```terraform
resource "aws_apprunner_vpc_ingress_connection" "example" {
  name        = "example"
  service_arn = aws_apprunner_service.example.arn

  ingress_vpc_configuration {
    vpc_id          = aws_default_vpc.default.id
    vpc_endpoint_id = aws_vpc_endpoint.apprunner.id
  }

  tags = {
    foo = "bar"
  }
}

```

## Argument Reference

The following arguments supported:

* `name` - (Required) A name for the VPC Ingress Connection resource. It must be unique across all the active VPC Ingress Connections in your AWS account in the AWS Region.
* `serviceArn` - (Required) The Amazon Resource Name (ARN) for this App Runner service that is used to create the VPC Ingress Connection resource.
* `ingressVpcConfiguration` - (Required) Specifications for the customer’s Amazon VPC and the related AWS PrivateLink VPC endpoint that are used to create the VPC Ingress Connection resource. See [Ingress VPC Configuration](#ingress-vpc-configuration) below for more details.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Ingress VPC Configuration

The `ingressVpcConfiguration` block supports the following argument:

* `vpcId` - (Required) The ID of the VPC that is used for the VPC endpoint.
* `vpcEndpointId` - (Required) The ID of the VPC endpoint that your App Runner service connects to.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) of the VPC Ingress Connection.
* `domainName` - The domain name associated with the VPC Ingress Connection resource.
* `status` - The current status of the VPC Ingress Connection.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

App Runner VPC Ingress Connection can be imported by using the `arn`, e.g.,

```
$ terraform import aws_apprunner_vpc_ingress_connection.example "arn:aws:apprunner:us-west-2:837424938642:vpcingressconnection/example/b379f86381d74825832c2e82080342fa"
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f04dea6fd29cfd5f66c42bbba8be21caefb93c8c2276a95998906e1bc3f32b5e -->