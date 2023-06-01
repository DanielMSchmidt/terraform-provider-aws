---
subcategory: "Elasticsearch"
layout: "aws"
page_title: "AWS: aws_elasticsearch_domain_saml_options"
description: |-
  Terraform resource for managing SAML authentication options for an AWS Elasticsearch Domain.
---

# Resource: aws_elasticsearch_domain_saml_options

Manages SAML authentication options for an AWS Elasticsearch Domain.

## Example Usage

### Basic Usage

```terraform
resource "aws_elasticsearch_domain" "example" {
  domain_name           = "example"
  elasticsearch_version = "1.5"

  cluster_config {
    instance_type = "r4.large.elasticsearch"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "TestDomain"
  }
}

resource "aws_elasticsearch_domain_saml_options" "example" {
  domain_name = aws_elasticsearch_domain.example.domain_name
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

* `samlOptions` - (Optional) The SAML authentication options for an AWS Elasticsearch Domain.

### saml_options

* `enabled` - (Required) Whether SAML authentication is enabled.
* `idp` - (Optional) Information from your identity provider.
* `masterBackendRole` - (Optional) This backend role from the SAML IdP receives full permissions to the cluster, equivalent to a new master user.
* `masterUserName` - (Optional) This username from the SAML IdP receives full permissions to the cluster, equivalent to a new master user.
* `rolesKey` - (Optional) Element of the SAML assertion to use for backend roles. Default is roles.
* `sessionTimeoutMinutes` - (Optional) Duration of a session in minutes after a user logs in. Default is 60. Maximum value is 1,440.
* `subjectKey` - (Optional) Custom SAML attribute to use for user names. Default is an empty string - `""`. This will cause Elasticsearch to use the `nameId` element of the `subject`, which is the default location for name identifiers in the SAML specification.

#### idp

* `entityId` - (Required) The unique Entity ID of the application in SAML Identity Provider.
* `metadataContent` - (Required) The Metadata of the SAML application in xml format.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The name of the domain the SAML options are associated with.

## Import

Elasticsearch domains can be imported using the `domainName`, e.g.,

```
$ terraform import aws_elasticsearch_domain_saml_options.example domain_name
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-8ffb946450cc78077453c97e71f3c68a4bc61076e8acd31ec84fedb7588aa0fc -->