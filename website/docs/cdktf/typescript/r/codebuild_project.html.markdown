---
subcategory: "CodeBuild"
layout: "aws"
page_title: "AWS: aws_codebuild_project"
description: |-
  Provides a CodeBuild Project resource.
---

# Resource: aws_codebuild_project

Provides a CodeBuild Project resource. See also the [`awsCodebuildWebhook` resource](/docs/providers/aws/r/codebuild_webhook.html), which manages the webhook to the source (e.g., the "rebuild every time a code change is pushed" option in the CodeBuild web console).

## Example Usage

```terraform
resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:us-east-1:123456789012:network-interface/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:Subnet"

      values = [
        aws_subnet.example1.arn,
        aws_subnet.example2.arn,
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.example.arn,
      "${aws_s3_bucket.example.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "example" {
  role   = aws_iam_role.example.name
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_codebuild_project" "example" {
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.example.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.example.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/mitchellh/packer.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  vpc_config {
    vpc_id = aws_vpc.example.id

    subnets = [
      aws_subnet.example1.id,
      aws_subnet.example2.id,
    ]

    security_group_ids = [
      aws_security_group.example1.id,
      aws_security_group.example2.id,
    ]
  }

  tags = {
    Environment = "Test"
  }
}

resource "aws_codebuild_project" "project-with-cache" {
  name           = "test-project-cache"
  description    = "test_codebuild_project_cache"
  build_timeout  = "5"
  queued_timeout = "5"

  service_role = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/mitchellh/packer.git"
    git_clone_depth = 1
  }

  tags = {
    Environment = "Test"
  }
}
```

## Argument Reference

The following arguments are required:

* `artifacts` - (Required) Configuration block. Detailed below.
* `environment` - (Required) Configuration block. Detailed below.
* `name` - (Required) Project's name.
* `serviceRole` - (Required) Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account.
* `source` - (Required) Configuration block. Detailed below.

The following arguments are optional:

* `badgeEnabled` - (Optional) Generates a publicly-accessible URL for the projects build badge. Available as `badgeUrl` attribute when enabled.
* `buildBatchConfig` - (Optional) Defines the batch build options for the project.
* `buildTimeout` - (Optional) Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes.
* `cache` - (Optional) Configuration block. Detailed below.
* `concurrentBuildLimit` - (Optional) Specify a maximum number of concurrent builds for the project. The value specified must be greater than 0 and less than the account concurrent running builds limit.
* `description` - (Optional) Short description of the project.
* `fileSystemLocations` - (Optional) A set of file system locations to mount inside the build. File system locations are documented below.
* `encryptionKey` - (Optional) AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts.
* `logsConfig` - (Optional) Configuration block. Detailed below.
* `projectVisibility` - (Optional) Specifies the visibility of the project's builds. Possible values are: `publicRead` and `private`. Default value is `private`.
* `resourceAccessRole` - The ARN of the IAM role that enables CodeBuild to access the CloudWatch Logs and Amazon S3 artifacts for the project's builds.
* `queuedTimeout` - (Optional) Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours.
* `secondaryArtifacts` - (Optional) Configuration block. Detailed below.
* `secondarySources` - (Optional) Configuration block. Detailed below.
* `secondarySourceVersion` - (Optional) Configuration block. Detailed below.
* `sourceVersion` - (Optional) Version of the build input to be built for this project. If not specified, the latest version is used.
* `tags` - (Optional) Map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `vpcConfig` - (Optional) Configuration block. Detailed below.

### artifacts

* `artifactIdentifier` - (Optional) Artifact identifier. Must be the same specified inside the AWS CodeBuild build specification.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. your CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.
* `encryptionDisabled` - (Optional) Whether to disable encrypting output artifacts. If `type` is set to `noArtifacts`, this value is ignored. Defaults to `false`.
* `location` - (Optional) Information about the build output artifact location. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored. If `type` is set to `s3`, this is the name of the output bucket.
* `name` - (Optional) Name of the project. If `type` is set to `s3`, this is the name of the output artifact object
* `namespaceType` - (Optional) Namespace to use in storing build artifacts. If `type` is set to `s3`, then valid values are `buildId`, `none`.
* `overrideArtifactName` (Optional) Whether a name specified in the build specification overrides the artifact name.
* `packaging` - (Optional) Type of build output artifact to create. If `type` is set to `s3`, valid values are `none`, `zip`
* `path` - (Optional) If `type` is set to `s3`, this is the path to the output artifact.
* `type` - (Required) Build output artifact's type. Valid values: `codepipeline`, `noArtifacts`, `s3`.

### build_batch_config

* `combineArtifacts` - (Optional) Specifies if the build artifacts for the batch build should be combined into a single artifact location.
* `restrictions` - (Optional) Configuration block specifying the restrictions for the batch build. Detailed below.
* `serviceRole` - (Required) Specifies the service role ARN for the batch build project.
* `timeoutInMins` - (Optional) Specifies the maximum amount of time, in minutes, that the batch build must be completed in.

#### build_batch_config: restrictions

* `computeTypesAllowed` - (Optional) An array of strings that specify the compute types that are allowed for the batch build. See [Build environment compute types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) in the AWS CodeBuild User Guide for these values.
* `maximumBuildsAllowed` - (Optional) Specifies the maximum number of builds allowed.

### cache

* `location` - (Required when cache type is `s3`) Location where the AWS CodeBuild project stores cached resources. For type `s3`, the value must be a valid S3 bucket name/prefix.
* `modes` - (Required when cache type is `local`) Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values:  `localSourceCache`, `localDockerLayerCache`, `localCustomCache`.
* `type` - (Optional) Type of storage that will be used for the AWS CodeBuild project cache. Valid values: `noCache`, `local`, `s3`. Defaults to `noCache`.

### environment

* `certificate` - (Optional) ARN of the S3 bucket, path prefix and object key that contains the PEM-encoded certificate.
* `computeType` - (Required) Information about the compute resources the build project will use. Valid values: `buildGeneral1Small`, `buildGeneral1Medium`, `buildGeneral1Large`, `buildGeneral12Xlarge`. `buildGeneral1Small` is only valid if `type` is set to `linuxContainer`. When `type` is set to `linuxGpuContainer`, `computeType` must be `buildGeneral1Large`.
* `environmentVariable` - (Optional) Configuration block. Detailed below.
* `imagePullCredentialsType` - (Optional) Type of credentials AWS CodeBuild uses to pull images in your build. Valid values: `codebuild`, `serviceRole`. When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CodeBuild credentials. Defaults to `codebuild`.
* `image` - (Required) Docker image to use for this build project. Valid values include [Docker images provided by CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) (e.g `aws/codebuild/standard:20`), [Docker Hub images](https://hub.docker.com/) (e.g., `hashicorp/terraform:latest`), and full Docker repository URIs such as those for ECR (e.g., `137112412989DkrEcrUsWest2AmazonawsCom/amazonlinux:latest`).
* `privilegedMode` - (Optional) Whether to enable running the Docker daemon inside a Docker container. Defaults to `false`.
* `registryCredential` - (Optional) Configuration block. Detailed below.
* `type` - (Required) Type of build environment to use for related builds. Valid values: `linuxContainer`, `linuxGpuContainer`, `windowsContainer` (deprecated), `windowsServer2019Container`, `armContainer`. For additional information, see the [CodeBuild User Guide](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html).

#### environment: environment_variable

* `name` - (Required) Environment variable's name or key.
* `type` - (Optional) Type of environment variable. Valid values: `parameterStore`, `plaintext`, `secretsManager`.
* `value` - (Required) Environment variable's value.

#### environment: registry_credential

Credentials for access to a private Docker registry.

* `credential` - (Required) ARN or name of credentials created using AWS Secrets Manager.
* `credentialProvider` - (Required) Service that created the credentials to access a private Docker registry. Valid value: `secretsManager` (AWS Secrets Manager).

### file_system_locations

See [ProjectFileSystemLocation](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectFileSystemLocation.html) for more details of the fields.

* `identifier` - (Optional) The name used to access a file system created by Amazon EFS. CodeBuild creates an environment variable by appending the identifier in all capital letters to CODEBUILD\_. For example, if you specify my-efs for identifier, a new environment variable is create named CODEBUILD_MY-EFS.
* `location` - (Optional) A string that specifies the location of the file system created by Amazon EFS. Its format is `efsDnsName:/directoryPath`.
* `mountOptions` - (Optional) The mount options for a file system created by AWS EFS.
* `mountPoint` - (Optional) The location in the container where you mount the file system.
* `type` - (Optional) The type of the file system. The one supported type is `efs`.

### logs_config

* `cloudwatchLogs` - (Optional) Configuration block. Detailed below.
* `s3Logs` - (Optional) Configuration block. Detailed below.

#### logs_config: cloudwatch_logs

* `groupName` - (Optional) Group name of the logs in CloudWatch Logs.
* `status` - (Optional) Current status of logs in CloudWatch Logs for a build project. Valid values: `enabled`, `disabled`. Defaults to `enabled`.
* `streamName` - (Optional) Stream name of the logs in CloudWatch Logs.

#### logs_config: s3_logs

* `encryptionDisabled` - (Optional) Whether to disable encrypting S3 logs. Defaults to `false`.
* `location` - (Optional) Name of the S3 bucket and the path prefix for S3 logs. Must be set if status is `enabled`, otherwise it must be empty.
* `status` - (Optional) Current status of logs in S3 for a build project. Valid values: `enabled`, `disabled`. Defaults to `disabled`.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. your CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.

### secondary_artifacts

* `artifactIdentifier` - (Required) Artifact identifier. Must be the same specified inside the AWS CodeBuild build specification.
* `bucketOwnerAccess` - (Optional) Specifies the bucket owner's access for objects that another account uploads to their Amazon S3 bucket. By default, only the account that uploads the objects to the bucket has access to these objects. This property allows you to give the bucket owner access to these objects. Valid values are `none`, `readOnly`, and `full`. The CodeBuild service role must have the `s3:putBucketAcl` permission. This permission allows CodeBuild to modify the access control list for the bucket.
* `encryptionDisabled` - (Optional) Whether to disable encrypting output artifacts. If `type` is set to `noArtifacts`, this value is ignored. Defaults to `false`.
* `location` - (Optional) Information about the build output artifact location. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored if specified. If `type` is set to `s3`, this is the name of the output bucket. If `path` is not specified, `location` can specify the path of the output artifact in the output bucket.
* `name` - (Optional) Name of the project. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored if specified. If `type` is set to `s3`, this is the name of the output artifact object.
* `namespaceType` - (Optional) Namespace to use in storing build artifacts. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored if specified. If `type` is set to `s3`, valid values are `buildId` or `none`.
* `overrideArtifactName` (Optional) Whether a name specified in the build specification overrides the artifact name.
* `packaging` - (Optional) Type of build output artifact to create. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored if specified. If `type` is set to `s3`, valid values are `none` or `zip`.
* `path` - (Optional) Along with `namespaceType` and `name`, the pattern that AWS CodeBuild uses to name and store the output artifact. If `type` is set to `codepipeline` or `noArtifacts`, this value is ignored if specified. If `type` is set to `s3`, this is the path to the output artifact.
* `type` - (Required) Build output artifact's type. Valid values `codepipeline`, `noArtifacts`, and `s3`.

### secondary_sources

* `buildspec` - (Optional) The build spec declaration to use for this build project's related builds. This must be set when `type` is `noSource`. It can either be a path to a file residing in the repository to be built or a local file path leveraging the `file()` built-in.
* `gitCloneDepth` - (Optional) Truncate git history to this many commits. Use `0` for a `full` checkout which you need to run commands like `git branch --show-current`. See [AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-github-gitclone.html) for details.
* `gitSubmodulesConfig` - (Optional) Configuration block. Detailed below.
* `insecureSsl` - (Optional) Ignore SSL warnings when connecting to source control.
* `location` - (Optional) Location of the source code from git or s3.
* `reportBuildStatus` - (Optional) Whether to report the status of a build's start and finish to your source provider. This option is only valid when your source provider is `github`, `bitbucket`, or `githubEnterprise`.
* `buildStatusConfig` - (Optional) Configuration block that contains information that defines how the build project reports the build status to the source provider. This option is only used when the source provider is `github`, `githubEnterprise`, or `bitbucket`. `buildStatusConfig` blocks are documented below.
* `sourceIdentifier` - (Required) An identifier for this project source. The identifier can only contain alphanumeric characters and underscores, and must be less than 128 characters in length.
* `type` - (Required) Type of repository that contains the source code to be built. Valid values: `codecommit`, `codepipeline`, `github`, `githubEnterprise`, `bitbucket` or `s3`.

#### secondary_sources: git_submodules_config

This block is only valid when the `type` is `codecommit`, `github` or `githubEnterprise`.

* `fetchSubmodules` - (Required) Whether to fetch Git submodules for the AWS CodeBuild build project.

#### secondary_sources: build_status_config

* `context` - (Optional) Specifies the context of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.
* `targetUrl` - (Optional) Specifies the target url of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.

### secondary_source_version

* `sourceIdentifier` - (Required) An identifier for a source in the build project.
* `sourceVersion` - (Required) The source version for the corresponding source identifier. See [AWS docs](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectSourceVersion.html#CodeBuild-Type-ProjectSourceVersion-sourceVersion) for more details.

### source

* `buildspec` - (Optional) Build specification to use for this build project's related builds. This must be set when `type` is `noSource`.
* `gitCloneDepth` - (Optional) Truncate git history to this many commits. Use `0` for a `full` checkout which you need to run commands like `git branch --show-current`. See [AWS CodePipeline User Guide: Tutorial: Use full clone with a GitHub pipeline source](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-github-gitclone.html) for details.
* `gitSubmodulesConfig` - (Optional) Configuration block. Detailed below.
* `insecureSsl` - (Optional) Ignore SSL warnings when connecting to source control.
* `location` - (Optional) Location of the source code from git or s3.
* `reportBuildStatus` - (Optional) Whether to report the status of a build's start and finish to your source provider. This option is only valid when the `type` is `bitbucket` or `github`.
* `buildStatusConfig` - (Optional) Configuration block that contains information that defines how the build project reports the build status to the source provider. This option is only used when the source provider is `github`, `githubEnterprise`, or `bitbucket`. `buildStatusConfig` blocks are documented below.
* `type` - (Required) Type of repository that contains the source code to be built. Valid values: `codecommit`, `codepipeline`, `github`, `githubEnterprise`, `bitbucket`, `s3`, `noSource`.

#### source: git_submodules_config

This block is only valid when the `type` is `codecommit`, `github` or `githubEnterprise`.

* `fetchSubmodules` - (Required) Whether to fetch Git submodules for the AWS CodeBuild build project.

#### source: build_status_config

* `context` - (Optional) Specifies the context of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.
* `targetUrl` - (Optional) Specifies the target url of the build status CodeBuild sends to the source provider. The usage of this parameter depends on the source provider.

### vpc_config

* `securityGroupIds` - (Required) Security group IDs to assign to running builds.
* `subnets` - (Required) Subnet IDs within which to run builds.
* `vpcId` - (Required) ID of the VPC within which to run builds.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the CodeBuild project.
* `badgeUrl` - URL of the build badge when `badgeEnabled` is enabled.
* `id` - Name (if imported via `name`) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project.
* `publicProjectAlias` - The project identifier used with the public build APIs.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

CodeBuild Project can be imported using the `name`, e.g.,

```
$ terraform import aws_codebuild_project.name project-name
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-7f06978d68097ee6bdebd6a7fc6c7089e0b2d2c5f39ceac4ef1cc63c2f046db5 -->