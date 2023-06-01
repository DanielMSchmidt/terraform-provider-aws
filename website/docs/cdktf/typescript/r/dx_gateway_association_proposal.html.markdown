---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_gateway_association_proposal"
description: |-
  Manages a Direct Connect Gateway Association Proposal.
---

# Resource: aws_dx_gateway_association_proposal

Manages a Direct Connect Gateway Association Proposal, typically for enabling cross-account associations. For single account associations, see the [`awsDxGatewayAssociation` resource](/docs/providers/aws/r/dx_gateway_association.html).

## Example Usage

```terraform
resource "aws_dx_gateway_association_proposal" "example" {
  dx_gateway_id               = aws_dx_gateway.example.id
  dx_gateway_owner_account_id = aws_dx_gateway.example.owner_account_id
  associated_gateway_id       = aws_vpn_gateway.example.id
}
```

A full example of how to create a VPN Gateway in one AWS account, create a Direct Connect Gateway in a second AWS account, and associate the VPN Gateway with the Direct Connect Gateway via the `awsDxGatewayAssociationProposal` and `awsDxGatewayAssociation` resources can be found in [the `/examples/dxGatewayCrossAccountVgwAssociation` directory within the Github Repository](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples/dx-gateway-cross-account-vgw-association).

## Argument Reference

The following arguments are supported:

* `associatedGatewayId` - (Required) The ID of the VGW or transit gateway with which to associate the Direct Connect gateway.
* `dxGatewayId` - (Required) Direct Connect Gateway identifier.
* `dxGatewayOwnerAccountId` - (Required) AWS Account identifier of the Direct Connect Gateway's owner.
* `allowedPrefixes` - (Optional) VPC prefixes (CIDRs) to advertise to the Direct Connect gateway. Defaults to the CIDR block of the VPC associated with the Virtual Gateway. To enable drift detection, must be configured.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - Direct Connect Gateway Association Proposal identifier.
* `associatedGatewayOwnerAccountId` - The ID of the AWS account that owns the VGW or transit gateway with which to associate the Direct Connect gateway.
* `associatedGatewayType` - The type of the associated gateway, `transitGateway` or `virtualPrivateGateway`.

## Import

Direct Connect Gateway Association Proposals can be imported using either a proposal ID or proposal ID, Direct Connect Gateway ID and associated gateway ID separated by `/`, e.g.,

```
$ terraform import aws_dx_gateway_association_proposal.example ac90e981-b718-4364-872d-65478c84fafe
```

or

```
$ terraform import aws_dx_gateway_association_proposal.example ac90e981-b718-4364-872d-65478c84fafe/abcd1234-dcba-5678-be23-cdef9876ab45/vgw-12345678
```

The latter case is useful when a previous proposal has been accepted and deleted by AWS.
The `awsDxGatewayAssociationProposal` resource will then represent a pseudo-proposal for the same Direct Connect Gateway and associated gateway.
If no previous proposal is available, use a tool like [`uuidgen`](http://manpages.ubuntu.com/manpages/bionic/man1/uuidgen.1.html) to generate a new random pseudo-proposal ID.

<!-- cache-key: cdktf-0.17.0-pre.15 input-1e1a6aa5db7d382ff77ff4014940a9bc0e026413a09e5676caf9a73fad463123 -->