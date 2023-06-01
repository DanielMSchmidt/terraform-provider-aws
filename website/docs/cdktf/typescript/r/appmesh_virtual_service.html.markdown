---
subcategory: "App Mesh"
layout: "aws"
page_title: "AWS: aws_appmesh_virtual_service"
description: |-
  Provides an AWS App Mesh virtual service resource.
---

# Resource: aws_appmesh_virtual_service

Provides an AWS App Mesh virtual service resource.

## Example Usage

### Virtual Node Provider

```terraform
resource "aws_appmesh_virtual_service" "servicea" {
  name      = "servicea.simpleapp.local"
  mesh_name = aws_appmesh_mesh.simple.id

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.serviceb1.name
      }
    }
  }
}
```

### Virtual Router Provider

```terraform
resource "aws_appmesh_virtual_service" "servicea" {
  name      = "servicea.simpleapp.local"
  mesh_name = aws_appmesh_mesh.simple.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.serviceb.name
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name to use for the virtual service. Must be between 1 and 255 characters in length.
* `meshName` - (Required) Name of the service mesh in which to create the virtual service. Must be between 1 and 255 characters in length.
* `meshOwner` - (Optional) AWS account ID of the service mesh's owner. Defaults to the account ID the [AWS provider][1] is currently connected to.
* `spec` - (Required) Virtual service specification to apply.
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

The `spec` object supports the following:

* `provider`- (Optional) App Mesh object that is acting as the provider for a virtual service. You can specify a single virtual node or virtual router.

The `provider` object supports the following:

* `virtualNode` - (Optional) Virtual node associated with a virtual service.
* `virtualRouter` - (Optional) Virtual router associated with a virtual service.

The `virtualNode` object supports the following:

* `virtualNodeName` - (Required) Name of the virtual node that is acting as a service provider. Must be between 1 and 255 characters in length.

The `virtualRouter` object supports the following:

* `virtualRouterName` - (Required) Name of the virtual router that is acting as a service provider. Must be between 1 and 255 characters in length.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - ID of the virtual service.
* `arn` - ARN of the virtual service.
* `createdDate` - Creation date of the virtual service.
* `lastUpdatedDate` - Last update date of the virtual service.
* `resourceOwner` - Resource owner's AWS account ID.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

App Mesh virtual services can be imported using `meshName` together with the virtual service's `name`,
e.g.,

```
$ terraform import aws_appmesh_virtual_service.servicea simpleapp/servicea.simpleapp.local
```

[1]: /docs/providers/aws/index.html

<!-- cache-key: cdktf-0.17.0-pre.15 input-263ce0f7bd61737fd049dc4a5a8784d4d4f0f695ce7f1d5356dd67fccc87cac9 -->