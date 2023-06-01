---
subcategory: "OpenSearch"
layout: "aws"
page_title: "AWS: aws_opensearch_domain_saml_options"
description: |-
  Terraform resource for managing SAML authentication options for an AWS OpenSearch Domain.
---

# Resource: aws_opensearch_domain_saml_options

Manages SAML authentication options for an AWS OpenSearch Domain.

## Example Usage

### Basic Usage

```terraform
resource "aws_opensearch_domain" "example" {
  domain_name    = "example"
  engine_version = "OpenSearch_1.1"

  cluster_config {
    instance_type = "r4.large.search"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "TestDomain"
  }
}

resource "aws_opensearch_domain_saml_options" "example" {
  domain_name = aws_opensearch_domain.example.domain_name
  saml_options {
    enabled = true
    idp {
      entity_id        = "https://example.com"
      metadata_content = file("./saml-metadata.xml")
    }
  }
}
```

## Argument Reference

The following arguments are required:

* `domainName` - (Required) Name of the domain.

The following arguments are optional:

* `samlOptions` - (Optional) SAML authentication options for an AWS OpenSearch Domain.

### saml_options

* `enabled` - (Required) Whether SAML authentication is enabled.
* `idp` - (Optional) Information from your identity provider.
* `masterBackendRole` - (Optional) This backend role from the SAML IdP receives full permissions to the cluster, equivalent to a new master user.
* `masterUserName` - (Optional) This username from the SAML IdP receives full permissions to the cluster, equivalent to a new master user.
* `rolesKey` - (Optional) Element of the SAML assertion to use for backend roles. Default is roles.
* `sessionTimeoutMinutes` - (Optional) Duration of a session in minutes after a user logs in. Default is 60. Maximum value is 1,440.
* `subjectKey` - (Optional) Element of the SAML assertion to use for username. Default is NameID.

#### idp

* `entityId` - (Required) Unique Entity ID of the application in SAML Identity Provider.
* `metadataContent` - (Required) Metadata of the SAML application in xml format.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Name of the domain the SAML options are associated with.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `update` - (Default `180M`)
* `delete` - (Default `90M`)

## Import

OpenSearch domains can be imported using the `domainName`, e.g.,

```
$ terraform import aws_opensearch_domain_saml_options.example domain_name
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-293a96a335d393e78825bd237e60f63565161a5a5f1b8c82808fd7e5eddb4ba6 -->