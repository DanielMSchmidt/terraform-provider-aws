---
subcategory: "ECR (Elastic Container Registry)"
layout: "aws"
page_title: "AWS: aws_ecr_replication_configuration"
description: |-
  Provides an Elastic Container Registry Replication Configuration.
---

# Resource: aws_ecr_replication_configuration

Provides an Elastic Container Registry Replication Configuration.

## Example Usage

```terraform
data "aws_caller_identity" "current" {}

data "aws_regions" "example" {}

resource "aws_ecr_replication_configuration" "example" {
  replication_configuration {
    rule {
      destination {
        region      = data.aws_regions.example.names[0]
        registry_id = data.aws_caller_identity.current.account_id
      }
    }
  }
}
```

## Multiple Region Usage

```terraform
data "aws_caller_identity" "current" {}

data "aws_regions" "example" {}

resource "aws_ecr_replication_configuration" "example" {
  replication_configuration {
    rule {
      destination {
        region      = data.aws_regions.example.names[0]
        registry_id = data.aws_caller_identity.current.account_id
      }

      destination {
        region      = data.aws_regions.example.names[1]
        registry_id = data.aws_caller_identity.current.account_id
      }
    }
  }
}
```

## Repository Filter Usage

```terraform
data "aws_caller_identity" "current" {}

data "aws_regions" "example" {}

resource "aws_ecr_replication_configuration" "example" {
  replication_configuration {
    rule {
      destination {
        region      = data.aws_regions.example.names[0]
        registry_id = data.aws_caller_identity.current.account_id
      }

      repository_filter {
        filter      = "prod-microservice"
        filter_type = "PREFIX_MATCH"
      }
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `replicationConfiguration` - (Required) Replication configuration for a registry. See [Replication Configuration](#replication-configuration).

### Replication Configuration

* `rule` - (Required) The replication rules for a replication configuration. A maximum of 10 are allowed per `replicationConfiguration`. See [Rule](#rule)

### Rule

* `destination` - (Required) the details of a replication destination. A maximum of 25 are allowed per `rule`. See [Destination](#destination).
* `repositoryFilter` - (Optional) filters for a replication rule. See [Repository Filter](#repository-filter).

### Destination

* `region` - (Required) A Region to replicate to.
* `registryId` - (Required) The account ID of the destination registry to replicate to.

### Repository Filter

* `filter` - (Required) The repository filter details.
* `filterType` - (Required) The repository filter type. The only supported value is `prefixMatch`, which is a repository name prefix specified with the filter parameter.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `registryId` - The registry ID where the replication configuration was created.

## Import

ECR Replication Configuration can be imported using the `registryId`, e.g.,

```
$ terraform import aws_ecr_replication_configuration.service 012345678912
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-cc262029c40ee11ad19fe1e711cac12c582a08555b65da0a9fe66ab981972a59 -->