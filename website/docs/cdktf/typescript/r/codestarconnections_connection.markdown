---
subcategory: "CodeStar Connections"
layout: "aws"
page_title: "AWS: aws_codestarconnections_connection"
description: |-
  Provides a CodeStar Connection
---

# Resource: aws_codestarconnections_connection

Provides a CodeStar Connection.

~> **NOTE:** The `awsCodestarconnectionsConnection` resource is created in the state `pending`. Authentication with the connection provider must be completed in the AWS Console. See the [AWS documentation](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-update.html) for details.

## Example Usage

```terraform
resource "aws_codestarconnections_connection" "example" {
  name          = "example-connection"
  provider_type = "Bitbucket"
}

resource "aws_codepipeline" "example" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    # ...
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.example.arn
        FullRepositoryId = "my-organization/test"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"
    action {
      # ...
    }
  }

  stage {
    name = "Deploy"
    action {
      # ...
    }
  }
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the connection to be created. The name must be unique in the calling AWS account. Changing `name` will create a new resource.
* `providerType` - (Optional) The name of the external provider where your third-party code repository is configured. Valid values are `bitbucket`, `gitHub` or `gitHubEnterpriseServer`. Changing `providerType` will create a new resource. Conflicts with `hostArn`
* `hostArn` - (Optional) The Amazon Resource Name (ARN) of the host associated with the connection. Conflicts with `providerType`
* `tags` - (Optional) Map of key-value resource tags to associate with the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The codestar connection ARN.
* `arn` - The codestar connection ARN.
* `connectionStatus` - The codestar connection status. Possible values are `pending`, `available` and `error`.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

CodeStar connections can be imported using the ARN, e.g.,

```
$ terraform import aws_codestarconnections_connection.test-connection arn:aws:codestar-connections:us-west-1:0123456789:connection/79d4d357-a2ee-41e4-b350-2fe39ae59448
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-3d459fbcea76f0cb2c074840d75472e252605235089a317e907b8822de3eac52 -->