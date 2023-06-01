---
subcategory: "CodePipeline"
layout: "aws"
page_title: "AWS: aws_codepipeline_webhook"
description: |-
  Provides a CodePipeline Webhook
---

# Resource: aws_codepipeline_webhook

Provides a CodePipeline Webhook.

## Example Usage

```terraform
resource "aws_codepipeline" "bar" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.bar.arn

  artifact_store {
    location = aws_s3_bucket.bar.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["test"]

      configuration = {
        Owner  = "my-organization"
        Repo   = "test"
        Branch = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["test"]
      version         = "1"

      configuration = {
        ProjectName = "test"
      }
    }
  }
}

# A shared secret between GitHub and AWS that allows AWS
# CodePipeline to authenticate the request came from GitHub.
# Would probably be better to pull this from the environment
# or something like SSM Parameter Store.
locals {
  webhook_secret = "super-secret"
}

resource "aws_codepipeline_webhook" "bar" {
  name            = "test-webhook-github-bar"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.bar.name

  authentication_configuration {
    secret_token = local.webhook_secret
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}

# Wire the CodePipeline webhook into a GitHub repository.
resource "github_repository_webhook" "bar" {
  repository = github_repository.repo.name

  name = "web"

  configuration {
    url          = aws_codepipeline_webhook.bar.url
    content_type = "json"
    insecure_ssl = true
    secret       = local.webhook_secret
  }

  events = ["push"]
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the webhook.
* `authentication` - (Required) The type of authentication  to use. One of `ip`, `githubHmac`, or `unauthenticated`.
* `authenticationConfiguration` - (Optional) An `auth` block. Required for `ip` and `githubHmac`. Auth blocks are documented below.
* `filter` (Required) One or more `filter` blocks. Filter blocks are documented below.
* `targetAction` - (Required) The name of the action in a pipeline you want to connect to the webhook. The action must be from the source (first) stage of the pipeline.
* `targetPipeline` - (Required) The name of the pipeline.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

An `authenticationConfiguration` block supports the following arguments:

* `secretToken` - (Optional) The shared secret for the GitHub repository webhook. Set this as `secret` in your `githubRepositoryWebhook`'s `configuration` block. Required for `githubHmac`.
* `allowedIpRange` - (Optional) A valid CIDR block for `ip` filtering. Required for `ip`.

A `filter` block supports the following arguments:

* `jsonPath` - (Required) The [JSON path](https://github.com/json-path/JsonPath) to filter on.
* `matchEquals` - (Required) The value to match on (e.g., `refs/heads/{branch}`). See [AWS docs](https://docs.aws.amazon.com/codepipeline/latest/APIReference/API_WebhookFilterRule.html) for details.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The CodePipeline webhook's ARN.
* `id` - The CodePipeline webhook's ARN.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `url` - The CodePipeline webhook's URL. POST events to this endpoint to trigger the target.

## Import

CodePipeline Webhooks can be imported by their ARN, e.g.,

```
$ terraform import aws_codepipeline_webhook.example arn:aws:codepipeline:us-west-2:123456789012:webhook:example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-aea5aeb746e957b6048b8c8e9b974592ad00c11025a3a9c5d7ebb2913235537c -->