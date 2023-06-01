---
subcategory: "Config"
layout: "aws"
page_title: "AWS: aws_config_organization_custom_policy_rule"
description: |-
  Terraform resource for managing an AWS Config Organization Custom Policy.
---

# Resource: aws_config_organization_custom_policy_rule

Manages a Config Organization Custom Policy Rule. More information about these rules can be found in the [Enabling AWS Config Rules Across all Accounts in Your Organization](https://docs.aws.amazon.com/config/latest/developerguide/config-rule-multi-account-deployment.html) and [AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html) documentation. For working with Organization Managed Rules (those invoking an AWS managed rule), see the [`awsConfigOrganizationManagedRule` resource](/docs/providers/aws/r/config_organization_managed_rule.html).

~> **NOTE:** This resource must be created in the Organization master account and rules will include the master account unless its ID is added to the `excludedAccounts` argument.

## Example Usage

### Basic Usage

```terraform
resource "aws_config_organization_custom_policy_rule" "example" {
  name = "example_rule_name"

  policy_runtime = "guard-2.x.x"
  policy_text    = <<-EOF
  let status = ['ACTIVE']

  rule tableisactive when
      resourceType == "AWS::DynamoDB::Table" {
      configuration.tableStatus == %status
  }

  rule checkcompliance when
      resourceType == "AWS::DynamoDB::Table"
      tableisactive {
          let pitr = supplementaryConfiguration.ContinuousBackupsDescription.pointInTimeRecoveryDescription.pointInTimeRecoveryStatus
          %pitr == "ENABLED"
      }
  EOF

  resource_types_scope = ["AWS::DynamoDB::Table"]
}
```

## Argument Reference

The following arguments are required:

* `name` - (Required) name of the rule
* `policyText` - (Required) policy definition containing the logic for your organization AWS Config Custom Policy rule
* `policyRuntime` - (Required)  runtime system for your organization AWS Config Custom Policy rules
* `triggerTypes` - (Required) List of notification types that trigger AWS Config to run an evaluation for the rule. Valid values: `configurationItemChangeNotification`, `oversizedConfigurationItemChangeNotification`

The following arguments are optional:

* `description` - (Optional) Description of the rule
* `debugLogDeliveryAccounts` - (Optional) List of AWS account identifiers to exclude from the rule
* `excludedAccounts` - (Optional) List of AWS account identifiers to exclude from the rule
* `inputParameters` - (Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function
* `maximumExecutionFrequency` - (Optional) Maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to `twentyFourHours` for periodic frequency triggered rules. Valid values: `oneHour`, `threeHours`, `sixHours`, `twelveHours`, or `twentyFourHours`.
* `resourceIdScope` - (Optional) Identifier of the AWS resource to evaluate
* `resourceTypesScope` - (Optional) List of types of AWS resources to evaluate
* `tagKeyScope` - (Optional, Required if `tagValueScope` is configured) Tag key of AWS resources to evaluate
* `tagValueScope` - (Optional) Tag value of AWS resources to evaluate

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the rule

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `20M`)
* `update` - (Default `20M`)
* `delete` - (Default `20M`)

## Import

A Config Organization Custom Policy Rule can be imported using the `name` argument, e.g.,

```
$ terraform import aws_config_organization_custom_policy_rule.example example_rule_name
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-9e08a177d744ed6540ba823b4bdd43fa89a3b966743db291e771d48b624b311c -->