---
subcategory: "CodeArtifact"
layout: "aws"
page_title: "AWS: aws_codeartifact_repository_endpoint"
description: |-
    Provides details about a CodeArtifact Repository Endpoint
---

# Data Source: aws_codeartifact_repository_endpoint

The CodeArtifact Repository Endpoint data source returns the endpoint of a repository for a specific package format.

## Example Usage

```terraform
data "aws_codeartifact_repository_endpoint" "test" {
  domain     = aws_codeartifact_domain.test.domain
  repository = aws_codeartifact_repository.test.repository
  format     = "npm"
}
```

## Argument Reference

The following arguments are supported:

* `domain` - (Required) Name of the domain that contains the repository.
* `repository` - (Required) Name of the repository.
* `format` - (Required) Which endpoint of a repository to return. A repository has one endpoint for each package format: `npm`, `pypi`, `maven`, and `nuget`.
* `domainOwner` - (Optional) Account number of the AWS account that owns the domain.

## Attributes Reference

In addition to the argument above, the following attributes are exported:

* `repositoryEndpoint` - URL of the returned endpoint.

<!-- cache-key: cdktf-0.17.0-pre.15 input-61760a559f1b547536cf0717d36b415b407eae564da6398815b5dc38141ca7c8 -->