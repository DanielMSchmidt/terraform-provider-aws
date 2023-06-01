---
subcategory: "KMS (Key Management)"
layout: "aws"
page_title: "AWS: aws_kms_custom_key_store"
description: |-
  Terraform resource for managing an AWS KMS (Key Management) Custom Key Store.
---

# Resource: aws_kms_custom_key_store

Terraform resource for managing an AWS KMS (Key Management) Custom Key Store.

## Example Usage

### Basic Usage

```terraform
resource "aws_kms_custom_key_store" "test" {
  cloud_hsm_cluster_id  = var.cloud_hsm_cluster_id
  custom_key_store_name = "kms-custom-key-store-test"
  key_store_password    = "noplaintextpasswords1"

  trust_anchor_certificate = file("anchor-certificate.crt")
}
```

## Argument Reference

The following arguments are required:

* `cloudHsmClusterId` - (Required) Cluster ID of CloudHSM.
* `customKeyStoreName` - (Required) Unique name for Custom Key Store.
* `keyStorePassword` - (Required) Password for `kmsuser` on CloudHSM.
* `trustAnchorCertificate` - (Required) Customer certificate used for signing on CloudHSM.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Custom Key Store ID

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `15M`)
* `update` - (Default `15M`)
* `delete` - (Default `15M`)

## Import

KMS (Key Management) Custom Key Store can be imported using the `id`, e.g.,

```
$ terraform import aws_kms_custom_key_store.example cks-5ebd4ef395a96288e
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-eb9e1ed040d894049b58db4746236c958bef363d2b9f5fdaea45fa6c5161a6a7 -->