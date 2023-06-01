---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_organization_custom_rule"
description: |-
  Manages a Config Organization Custom Rule
---

# Resource: aws_config_organization_custom_rule

Manages a Config Organization Custom Rule. More information about these rules can be found in the [Enabling AWS Config Rules Across all Accounts in Your Organization](https://docs.aws.amazon.com/config/latest/developerguide/config-rule-multi-account-deployment.html) and [AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html) documentation. For working with Organization Managed Rules (those invoking an AWS managed rule), see the [`awsConfigOrganizationManagedRule` resource](/docs/providers/aws/r/config_organization_managed_rule.html).

~> **NOTE:** This resource must be created in the Organization master account and rules will include the master account unless its ID is added to the `excludedAccounts` argument.

~> **NOTE:** The proper Lambda permission to allow the AWS Config service invoke the Lambda Function must be in place before the rule will successfully create or update. See also the [`awsLambdaPermission` resource](/docs/providers/aws/r/lambda_permission.html).

## Example Usage

```terraform
resource "aws_lambda_permission" "example" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.arn
  principal     = "config.amazonaws.com"
  statement_id  = "AllowExecutionFromConfig"
}

resource "aws_organizations_organization" "example" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_config_organization_custom_rule" "example" {
  depends_on = [
    aws_lambda_permission.example,
    aws_organizations_organization.example,
  ]

  lambda_function_arn = aws_lambda_function.example.arn
  name                = "example"
  trigger_types       = ["ConfigurationItemChangeNotification"]
}
```

## Argument Reference

The following arguments are supported:

* `lambdaFunctionArn` - (Required) Amazon Resource Name (ARN) of the rule Lambda Function
* `name` - (Required) The name of the rule
* `triggerTypes` - (Required) List of notification types that trigger AWS Config to run an evaluation for the rule. Valid values: `configurationItemChangeNotification`, `oversizedConfigurationItemChangeNotification`, and `scheduledNotification`
* `description` - (Optional) Description of the rule
* `excludedAccounts` - (Optional) List of AWS account identifiers to exclude from the rule
* `inputParameters` - (Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function
* `maximumExecutionFrequency` - (Optional) The maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to `twentyFourHours` for periodic frequency triggered rules. Valid values: `oneHour`, `threeHours`, `sixHours`, `twelveHours`, or `twentyFourHours`.
* `resourceIdScope` - (Optional) Identifier of the AWS resource to evaluate
* `resourceTypesScope` - (Optional) List of types of AWS resources to evaluate
* `tagKeyScope` - (Optional, Required if `tagValueScope` is configured) Tag key of AWS resources to evaluate
* `tagValueScope` - (Optional) Tag value of AWS resources to evaluate

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the rule

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `5M`)
* `delete` - (Default `5M`)
* `update` - (Default `5M`)

## Import

Config Organization Custom Rules can be imported using the name, e.g.,

```
$ terraform import aws_config_organization_custom_rule.example example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-30f3ff435ea229ef8b9f1413bfc67979ef9fb6618b9219e3c894b7f5d41fccab -->