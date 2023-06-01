---
subcategory: "OpsWorks"
layout: "aws"
page_title: "AWS: aws_opsworks_application"
description: |-
  Provides an OpsWorks application resource.
---

# Resource: aws_opsworks_application

Provides an OpsWorks application resource.

## Example Usage

```terraform
resource "aws_opsworks_application" "foo-app" {
  name        = "foobar application"
  short_name  = "foobar"
  stack_id    = aws_opsworks_stack.main.id
  type        = "rails"
  description = "This is a Rails application"

  domains = [
    "example.com",
    "sub.example.com",
  ]

  environment {
    key    = "key"
    value  = "value"
    secure = false
  }

  app_source {
    type     = "git"
    revision = "master"
    url      = "https://github.com/example.git"
  }

  enable_ssl = true

  ssl_configuration {
    private_key = file("./foobar.key")
    certificate = file("./foobar.crt")
  }

  document_root         = "public"
  auto_bundle_on_deploy = true
  rails_env             = "staging"
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) A human-readable name for the application.
* `shortName` - (Required) A short, machine-readable name for the application. This can only be defined on resource creation and ignored on resource update.
* `stackId` - (Required) ID of the stack the application will belong to.
* `type` - (Required) Opsworks application type. One of `awsFlowRuby`, `java`, `rails`, `php`, `nodejs`, `static` or `other`.
* `description` - (Optional) A description of the app.
* `environment` - (Optional) Object to define environment variables.  Object is described below.
* `enableSsl` - (Optional) Whether to enable SSL for the app. This must be set in order to let `sslConfigurationPrivateKey`, `sslConfigurationCertificate` and `sslConfigurationChain` take effect.
* `sslConfiguration` - (Optional) The SSL configuration of the app. Object is described below.
* `appSource` - (Optional) SCM configuration of the app as described below.
* `dataSourceArn` - (Optional) The data source's ARN.
* `dataSourceType` - (Optional) The data source's type one of `autoSelectOpsworksMysqlInstance`, `opsworksMysqlInstance`, or `rdsDbInstance`.
* `dataSourceDatabaseName` - (Optional) The database name.
* `domains` -  (Optional) A list of virtual host alias.
* `documentRoot` - (Optional) Subfolder for the document root for application of type `rails`.
* `autoBundleOnDeploy` - (Optional) Run bundle install when deploying for application of type `rails`.
* `railsEnv` - (Required if `type` = `rails`) The name of the Rails environment for application of type `rails`.
* `awsFlowRubySettings` - (Optional) Specify activity and workflow workers for your app using the aws-flow gem.

An `appSource` block supports the following arguments (can only be defined once per resource):

* `type` - (Required) The type of source to use. For example, "archive".
* `url` - (Required) The URL where the app resource can be found.
* `username` - (Optional) Username to use when authenticating to the source.
* `password` - (Optional) Password to use when authenticating to the source. Terraform cannot perform drift detection of this configuration.
* `sshKey` - (Optional) SSH key to use when authenticating to the source. Terraform cannot perform drift detection of this configuration.
* `revision` - (Optional) For sources that are version-aware, the revision to use.

An `environment` block supports the following arguments:

* `key` - (Required) Variable name.
* `value` - (Required) Variable value.
* `secure` - (Optional) Set visibility of the variable value to `true` or `false`.

A `sslConfiguration` block supports the following arguments (can only be defined once per resource):

* `privateKey` - (Required) The private key; the contents of the certificate's domain.key file.
* `certificate` - (Required) The contents of the certificate's domain.crt file.
* `chain` - (Optional)  Can be used to specify an intermediate certificate authority key or client authentication.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The id of the application.

## Import

Opsworks Application can be imported using the `id`, e.g.,

```
$ terraform import aws_opsworks_application.test <id>
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-0aa97b434658c36679bb4dc22ae1cbf819c784de985ade9fa96f60a3f59be4ab -->