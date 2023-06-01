---
subcategory: "Cognito IDP (Identity Provider)"
layout: "aws"
page_title: "AWS: aws_cognito_risk_configuration"
description: |-
  Provides a Cognito Risk Configuration resource.
---

# Resource: aws_cognito_risk_configuration

Provides a Cognito Risk Configuration resource.

## Example Usage

```terraform
resource "aws_cognito_risk_configuration" "example" {
  user_pool_id = aws_cognito_user_pool.example.id

  risk_exception_configuration {
    blocked_ip_range_list = ["10.10.10.10/32"]
  }
}
```

## Argument Reference

The following arguments are supported:

* `userPoolId` - (Required) The user pool ID.
* `clientId` - (Optional) The app client ID. When the client ID is not provided, the same risk configuration is applied to all the clients in the User Pool.
* `accountTakeoverRiskConfiguration` - (Optional) The account takeover risk configuration. See details below.
* `compromisedCredentialsRiskConfiguration` - (Optional) The compromised credentials risk configuration. See details below.
* `riskExceptionConfiguration` - (Optional) The configuration to override the risk decision. See details below.

### account_takeover_risk_configuration

* `notifyConfiguration` - (Required) The notify configuration used to construct email notifications. See details below.
* `actions` - (Required) Account takeover risk configuration actions. See details below.

#### notify_configuration

* `blockEmail` - (Optional) Email template used when a detected risk event is blocked. See notify email type below.
* `mfaEmail` - (Optional) The multi-factor authentication (MFA) email template used when MFA is challenged as part of a detected risk. See notify email type below.
* `noActionEmail` - (Optional) The email template used when a detected risk event is allowed. See notify email type below.
* `from` - (Optional) The email address that is sending the email. The address must be either individually verified with Amazon Simple Email Service, or from a domain that has been verified with Amazon SES.
* `replyTo` - (Optional) The destination to which the receiver of an email should reply to.
* `sourceArn` - (Required) The Amazon Resource Name (ARN) of the identity that is associated with the sending authorization policy. This identity permits Amazon Cognito to send for the email address specified in the From parameter.

##### notify email type

* `htmlBody` - (Required) The email HTML body.
* `subject` - (Required) The email subject.
* `textBody` - (Required) The email text body.

#### actions

* `highAction` - (Optional) Action to take for a high risk. See action block below.
* `lowAction` - (Optional) Action to take for a low risk. See action block below.
* `mediumAction` - (Optional) Action to take for a medium risk. See action block below.

##### action

* `eventAction` - (Required) The action to take in response to the account takeover action. Valid values are `block`, `mfaIfConfigured`, `mfaRequired` and `noAction`.
* `notify` - (Required) Whether to send a notification.

### compromised_credentials_risk_configuration

* `eventFilter` - (Optional) Perform the action for these events. The default is to perform all events if no event filter is specified. Valid values are `signIn`, `passwordChange`, and `signUp`.
* `actions` - (Required) The compromised credentials risk configuration actions. See details below.

#### actions

* `eventAction` - (Optional) The event action. Valid values are `block` or `noAction`.

### risk_exception_configuration

* `blockedIpRangeList` - (Optional) Overrides the risk decision to always block the pre-authentication requests.
  The IP range is in CIDR notation, a compact representation of an IP address and its routing prefix.
  Can contain a maximum of 200 items.
* `skippedIpRangeList` - (Optional) Risk detection isn't performed on the IP addresses in this range list.
  The IP range is in CIDR notation.
  Can contain a maximum of 200 items.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The user pool ID. or The user pool ID and Client Id separated by a `:` if the configuration is client specific.

## Import

Cognito Risk Configurations can be imported using the `id`, e.g.,

```
$ terraform import aws_cognito_risk_configuration.main example
```

```
$ terraform import aws_cognito_risk_configuration.main example:example
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-c0429177fd50ddc4ad93ff213a8c659407b9dad3f40ecb63f92b0236f0638040 -->