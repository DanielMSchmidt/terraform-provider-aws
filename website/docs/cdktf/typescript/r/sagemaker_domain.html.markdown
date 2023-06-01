---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_domain"
description: |-
  Provides a SageMaker Domain resource.
---

# Resource: aws_sagemaker_domain

Provides a SageMaker Domain resource.

## Example Usage

### Basic usage

```terraform
resource "aws_sagemaker_domain" "example" {
  domain_name = "example"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.example.id
  subnet_ids  = [aws_subnet.example.id]

  default_user_settings {
    execution_role = aws_iam_role.example.arn
  }
}

resource "aws_iam_role" "example" {
  name               = "example"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}
```

### Using Custom Images

```terraform
resource "aws_sagemaker_image" "example" {
  image_name = "example"
  role_arn   = aws_iam_role.example.arn
}

resource "aws_sagemaker_app_image_config" "example" {
  app_image_config_name = "example"

  kernel_gateway_image_config {
    kernel_spec {
      name = "example"
    }
  }
}

resource "aws_sagemaker_image_version" "example" {
  image_name = aws_sagemaker_image.example.id
  base_image = "base-image"
}

resource "aws_sagemaker_domain" "example" {
  domain_name = "example"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.example.id
  subnet_ids  = [aws_subnet.example.id]

  default_user_settings {
    execution_role = aws_iam_role.example.arn

    kernel_gateway_app_settings {
      custom_image {
        app_image_config_name = aws_sagemaker_app_image_config.example.app_image_config_name
        image_name            = aws_sagemaker_image_version.example.image_name
      }
    }
  }
}
```

## Argument Reference

The following arguments are required:

* `authMode` - (Required) The mode of authentication that members use to access the domain. Valid values are `iam` and `sso`.
* `defaultSpaceSettings` - (Required) The default space settings. See [Default Space Settings](#default_space_settings) below.
* `defaultUserSettings` - (Required) The default user settings. See [Default User Settings](#default_user_settings) below.* `domainName` - (Required) The domain name.
* `subnetIds` - (Required) The VPC subnets that Studio uses for communication.
* `vpcId` - (Required) The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication.

The following arguments are optional:

* `appNetworkAccessType` - (Optional) Specifies the VPC used for non-EFS traffic. The default value is `publicInternetOnly`. Valid values are `publicInternetOnly` and `vpcOnly`.
* `appSecurityGroupManagement` - (Optional) The entity that creates and manages the required security groups for inter-app communication in `vpcOnly` mode. Valid values are `service` and `customer`.
* `domainSettings` - (Optional) The domain settings. See [Domain Settings](#domain_settings) below.
* `domainSettings` - (Optional) The domain's settings.
* `kmsKeyId` - (Optional) The AWS KMS customer managed CMK used to encrypt the EFS volume attached to the domain.
* `retentionPolicy` - (Optional) The retention policy for this domain, which specifies whether resources will be retained after the Domain is deleted. By default, all resources are retained. See [Retention Policy](#retention_policy) below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### default_space_settings

* `executionRole` - (Required) The execution role for the space.
* `jupyterServerAppSettings` - (Optional) The Jupyter server's app settings. See [Jupyter Server App Settings](#jupyter_server_app_settings) below.
* `kernelGatewayAppSettings` - (Optional) The kernel gateway app settings. See [Kernel Gateway App Settings](#kernel_gateway_app_settings) below.
* `securityGroups` - (Optional) The security groups for the Amazon Virtual Private Cloud that the space uses for communication.

### default_user_settings

* `executionRole` - (Required) The execution role ARN for the user.
* `canvasAppSettings` - (Optional) The Canvas app settings. See [Canvas App Settings](#canvas_app_settings) below.
* `jupyterServerAppSettings` - (Optional) The Jupyter server's app settings. See [Jupyter Server App Settings](#jupyter_server_app_settings) below.
* `kernelGatewayAppSettings` - (Optional) The kernel gateway app settings. See [Kernel Gateway App Settings](#kernel_gateway_app_settings) below.
* `rSessionAppSettings` - (Optional) The RSession app settings. See [RSession App Settings](#r_session_app_settings) below.
* `rStudioServerProAppSettings` - (Optional) A collection of settings that configure user interaction with the RStudioServerPro app. See [RStudioServerProAppSettings](#r_studio_server_pro_app_settings) below.
* `securityGroups` - (Optional) A list of security group IDs that will be attached to the user.
* `sharingSettings` - (Optional) The sharing settings. See [Sharing Settings](#sharing_settings) below.
* `tensorBoardAppSettings` - (Optional) The TensorBoard app settings. See [TensorBoard App Settings](#tensor_board_app_settings) below.

#### r_studio_server_pro_app_settings

* `accessStatus` - (Optional) Indicates whether the current user has access to the RStudioServerPro app. Valid values are `enabled` and `disabled`.
* `userGroup` - (Optional) The level of permissions that the user has within the RStudioServerPro app. This value defaults to `rStudioUser`. The `rStudioAdmin` value allows the user access to the RStudio Administrative Dashboard. Valid values are `rStudioUser` and `rStudioAdmin`.

#### canvas_app_settings

* `modelRegisterSettings` - (Optional) The model registry settings for the SageMaker Canvas application. See [Model Register Settings](#model_register_settings) below.
* `timeSeriesForecastingSettings` - (Optional) Time series forecast settings for the Canvas app. See [Time Series Forecasting Settings](#time_series_forecasting_settings) below.

##### model_register_settings

* `crossAccountModelRegisterRoleArn` - (Optional) The Amazon Resource Name (ARN) of the SageMaker model registry account. Required only to register model versions created by a different SageMaker Canvas AWS account than the AWS account in which SageMaker model registry is set up.
* `status` - (Optional) Describes whether the integration to the model registry is enabled or disabled in the Canvas application.. Valid values are `enabled` and `disabled`.

##### time_series_forecasting_settings

* `amazonForecastRoleArn` - (Optional) The IAM role that Canvas passes to Amazon Forecast for time series forecasting. By default, Canvas uses the execution role specified in the UserProfile that launches the Canvas app. If an execution role is not specified in the UserProfile, Canvas uses the execution role specified in the Domain that owns the UserProfile. To allow time series forecasting, this IAM role should have the [AmazonSageMakerCanvasForecastAccess](https://docs.aws.amazon.com/sagemaker/latest/dg/security-iam-awsmanpol-canvas.html#security-iam-awsmanpol-AmazonSageMakerCanvasForecastAccess) policy attached and forecast.amazonaws.com added in the trust relationship as a service principal.
* `status` - (Optional) Describes whether time series forecasting is enabled or disabled in the Canvas app. Valid values are `enabled` and `disabled`.

#### sharing_settings

* `notebookOutputOption` - (Optional) Whether to include the notebook cell output when sharing the notebook. The default is `disabled`. Valid values are `allowed` and `disabled`.
* `s3KmsKeyId` - (Optional) When `notebookOutputOption` is Allowed, the AWS Key Management Service (KMS) encryption key ID used to encrypt the notebook cell output in the Amazon S3 bucket.
* `s3OutputPath` - (Optional) When `notebookOutputOption` is Allowed, the Amazon S3 bucket used to save the notebook cell output.

#### tensor_board_app_settings

* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default_resource_spec) below.

#### kernel_gateway_app_settings

* `customImage` - (Optional) A list of custom SageMaker images that are configured to run as a KernelGateway app. see [Custom Image](#custom_image) below.
* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default_resource_spec) below.
* `lifecycleConfigArns` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configurations.

#### jupyter_server_app_settings

* `codeRepository` - (Optional) A list of Git repositories that SageMaker automatically displays to users for cloning in the JupyterServer application. see [Code Repository](#code_repository) below.
* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default_resource_spec) below.
* `lifecycleConfigArns` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configurations.

##### code_repository

* `repositoryUrl` - (Optional) The URL of the Git repository.

##### default_resource_spec

* `instanceType` - (Optional) The instance type that the image version runs on.. For valid values see [SageMaker Instance Types](https://docs.aws.amazon.com/sagemaker/latest/dg/notebooks-available-instance-types.html).
* `lifecycleConfigArn` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configuration attached to the Resource.
* `sagemakerImageArn` - (Optional) The ARN of the SageMaker image that the image version belongs to.
* `sagemakerImageVersionArn` - (Optional) The ARN of the image version created on the instance.

#### r_session_app_settings

* `customImage` - (Optional) A list of custom SageMaker images that are configured to run as a KernelGateway app. see [Custom Image](#custom_image) below.
* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default_resource_spec) below.

##### custom_image

* `appImageConfigName` - (Required) The name of the App Image Config.
* `imageName` - (Required) The name of the Custom Image.
* `imageVersionNumber` - (Optional) The version number of the Custom Image.

### domain_settings

* `executionRoleIdentityConfig` - (Optional) The configuration for attaching a SageMaker user profile name to the execution role as a sts:SourceIdentity key [AWS Docs](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html). Valid values are `userProfileName` and `disabled`.
* `rStudioServerProDomainSettings` - (Optional) A collection of settings that configure the RStudioServerPro Domain-level app. see [RStudioServerProDomainSettings](#r_studio_server_pro_domain_settings) below.
* `securityGroupIds` - (Optional) The security groups for the Amazon Virtual Private Cloud that the Domain uses for communication between Domain-level apps and user apps.

#### r_studio_server_pro_domain_settings

* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default_resource_spec) below.
* `domainExecutionRoleArn` - (Required) The ARN of the execution role for the RStudioServerPro Domain-level app.
* `rStudioConnectUrl` - (Optional) A URL pointing to an RStudio Connect server.
* `rStudioPackageManagerUrl` - (Optional) A URL pointing to an RStudio Package Manager server.

### retention_policy

* `homeEfsFileSystem` - (Optional) The retention policy for data stored on an Amazon Elastic File System (EFS) volume. Valid values are `retain` or `delete`.  Default value is `retain`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the Domain.
* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Domain.
* `url` - The domain's URL.
* `singleSignOnManagedApplicationInstanceId` - The SSO managed application instance ID.
* `securityGroupIdForDomainBoundary` - The ID of the security group that authorizes traffic between the RSessionGateway apps and the RStudioServerPro app.
* `homeEfsFileSystemId` - The ID of the Amazon Elastic File System (EFS) managed by this Domain.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

SageMaker Domains can be imported using the `id`, e.g.,

```
$ terraform import aws_sagemaker_domain.test_domain d-8jgsjtilstu8
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-442f2900e81654aa6183d0a60e1c029db78b97dd53255434f8a1928cd6eb1a54 -->