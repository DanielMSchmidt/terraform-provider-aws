---
subcategory: "OpenSearch"
layout: "aws"
page_title: "AWS: aws_opensearch_outbound_connection"
description: |-
  Terraform resource for managing an AWS OpenSearch Outbound Connection.
---

# Resource: aws_opensearch_outbound_connection

Manages an AWS Opensearch Outbound Connection.

## Example Usage

### Basic Usage

```terraform
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_opensearch_outbound_connection" "foo" {
  connection_alias = "outbound_connection"
  local_domain_info {
    owner_id    = data.aws_caller_identity.current.account_id
    region      = data.aws_region.current.name
    domain_name = aws_opensearch_domain.local_domain.domain_name
  }

  remote_domain_info {
    owner_id    = data.aws_caller_identity.current.account_id
    region      = data.aws_region.current.name
    domain_name = aws_opensearch_domain.remote_domain.domain_name
  }
}
```

## Argument Reference

The following arguments are supported:

* `connectionAlias` - (Required, Forces new resource) Specifies the connection alias that will be used by the customer for this connection.
* `localDomainInfo` - (Required, Forces new resource) Configuration block for the local Opensearch domain.
* `remoteDomainInfo` - (Required, Forces new resource) Configuration block for the remote Opensearch domain.

### local_domain_info

* `ownerId` - (Required, Forces new resource) The Account ID of the owner of the local domain.
* `domainName` - (Required, Forces new resource) The name of the local domain.
* `region` - (Required, Forces new resource) The region of the local domain.

### remote_domain_info

* `ownerId` - (Required, Forces new resource) The Account ID of the owner of the remote domain.
* `domainName` - (Required, Forces new resource) The name of the remote domain.
* `region` - (Required, Forces new resource) The region of the remote domain.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Id of the connection.
* `connectionStatus` - Status of the connection request.

## Import

AWS Opensearch Outbound Connections can be imported by using the Outbound Connection ID, e.g.,

```
$ terraform import aws_opensearch_outbound_connection.foo connection-id
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-878c574440ee1fc6bdf29efe678dbbd8f6f4e58ce853d7c5ece9bedbdef72acb -->