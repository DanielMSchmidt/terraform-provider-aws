---
subcategory: "CloudFormation"
layout: "aws"
page_title: "AWS: aws_cloudformation_stack_set_instance"
description: |-
  Manages a CloudFormation StackSet Instance.
---

# Resource: aws_cloudformation_stack_set_instance

Manages a CloudFormation StackSet Instance. Instances are managed in the account and region of the StackSet after the target account permissions have been configured. Additional information about StackSets can be found in the [AWS CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/what-is-cfnstacksets.html).

~> **NOTE:** All target accounts must have an IAM Role created that matches the name of the execution role configured in the StackSet (the `executionRoleName` argument in the `awsCloudformationStackSet` resource) in a trust relationship with the administrative account or administration IAM Role. The execution role must have appropriate permissions to manage resources defined in the template along with those required for StackSets to operate. See the [AWS CloudFormation User Guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html) for more details.

~> **NOTE:** To retain the Stack during Terraform resource destroy, ensure `retain_stack = true` has been successfully applied into the Terraform state first. This must be completed _before_ an apply that would destroy the resource.

## Example Usage

```terraform
resource "aws_cloudformation_stack_set_instance" "example" {
  account_id     = "123456789012"
  region         = "us-east-1"
  stack_set_name = aws_cloudformation_stack_set.example.name
}
```

### Example IAM Setup in Target Account

```terraform
data "aws_iam_policy_document" "AWSCloudFormationStackSetExecutionRole_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = [aws_iam_role.AWSCloudFormationStackSetAdministrationRole.arn]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "AWSCloudFormationStackSetExecutionRole" {
  assume_role_policy = data.aws_iam_policy_document.AWSCloudFormationStackSetExecutionRole_assume_role_policy.json
  name               = "AWSCloudFormationStackSetExecutionRole"
}

# Documentation: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html
# Additional IAM permissions necessary depend on the resources defined in the StackSet template
data "aws_iam_policy_document" "AWSCloudFormationStackSetExecutionRole_MinimumExecutionPolicy" {
  statement {
    actions = [
      "cloudformation:*",
      "s3:*",
      "sns:*",
    ]

    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "AWSCloudFormationStackSetExecutionRole_MinimumExecutionPolicy" {
  name   = "MinimumExecutionPolicy"
  policy = data.aws_iam_policy_document.AWSCloudFormationStackSetExecutionRole_MinimumExecutionPolicy.json
  role   = aws_iam_role.AWSCloudFormationStackSetExecutionRole.name
}
```

### Example Deployment across Organizations account

```terraform
resource "aws_cloudformation_stack_set_instance" "example" {
  deployment_targets {
    organizational_unit_ids = [aws_organizations_organization.example.roots[0].id]
  }

  region         = "us-east-1"
  stack_set_name = aws_cloudformation_stack_set.example.name
}
```

## Argument Reference

The following arguments are supported:

* `stackSetName` - (Required) Name of the StackSet.
* `accountId` - (Optional) Target AWS Account ID to create a Stack based on the StackSet. Defaults to current account.
* `deploymentTargets` - (Optional) The AWS Organizations accounts to which StackSets deploys. StackSets doesn't deploy stack instances to the organization management account, even if the organization management account is in your organization or in an OU in your organization. Drift detection is not possible for this argument. See [deployment_targets](#deployment_targets-argument-reference) below.
* `parameterOverrides` - (Optional) Key-value map of input parameters to override from the StackSet for this Instance.
* `region` - (Optional) Target AWS Region to create a Stack based on the StackSet. Defaults to current region.
* `retainStack` - (Optional) During Terraform resource destroy, remove Instance from StackSet while keeping the Stack and its associated resources. Must be enabled in Terraform state _before_ destroy operation to take effect. You cannot reassociate a retained Stack or add an existing, saved Stack to a new StackSet. Defaults to `false`.
* `callAs` - (Optional) Specifies whether you are acting as an account administrator in the organization's management account or as a delegated administrator in a member account. Valid values: `self` (default), `delegatedAdmin`.
* `operationPreferences` - (Optional) Preferences for how AWS CloudFormation performs a stack set operation.

### `deploymentTargets` Argument Reference

The `deploymentTargets` configuration block supports the following arguments:

* `organizationalUnitIds` - (Optional) The organization root ID or organizational unit (OU) IDs to which StackSets deploys.

### `operationPreferences` Argument Reference

The `operationPreferences` configuration block supports the following arguments:

* `failureToleranceCount` - (Optional) The number of accounts, per Region, for which this operation can fail before AWS CloudFormation stops the operation in that Region.
* `failureTolerancePercentage` - (Optional) The percentage of accounts, per Region, for which this stack operation can fail before AWS CloudFormation stops the operation in that Region.
* `maxConcurrentCount` - (Optional) The maximum number of accounts in which to perform this operation at one time.
* `maxConcurrentPercentage` - (Optional) The maximum percentage of accounts in which to perform this operation at one time.
* `regionConcurrencyType` - (Optional) The concurrency type of deploying StackSets operations in Regions, could be in parallel or one Region at a time. Valid values are `sequential` and `parallel`.
* `regionOrder` - (Optional) The order of the Regions in where you want to perform the stack operation.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - StackSet name, target AWS account ID, and target AWS region separated by commas (`,`)
* `organizationalUnitId` - The organization root ID or organizational unit (OU) IDs specified for `deploymentTargets`.
* `stackId` - Stack identifier

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

CloudFormation StackSet Instances that target an AWS Account ID can be imported using the StackSet name, target AWS account ID, and target AWS region separated by commas (`,`) e.g.

```
$ terraform import aws_cloudformation_stack_set_instance.example example,123456789012,us-east-1
```

CloudFormation StackSet Instances that target AWS Organizational Units can be imported using the StackSet name, a slash (`/`) separated list of organizational unit IDs, and target AWS region separated by commas (`,`) e.g.

```
$ terraform import aws_cloudformation_stack_set_instance.example example,ou-sdas-123123123/ou-sdas-789789789,us-east-1
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-35b26bc5b026d7ab9c55eb0c73dc837e390f0614d4b36fb6d5bdc30bc6a6dbdc -->