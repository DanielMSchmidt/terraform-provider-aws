---
subcategory: "IoT Core"
layout: "aws"
page_title: "AWS: aws_iot_thing_principal_attachment"
description: |-
    Provides AWS IoT Thing Principal attachment.
---

# Resource: aws_iot_thing_principal_attachment

Attaches Principal to AWS IoT Thing.

## Example Usage

```terraform
resource "aws_iot_thing" "example" {
  name = "example"
}

resource "aws_iot_certificate" "cert" {
  csr    = file("csr.pem")
  active = true
}

resource "aws_iot_thing_principal_attachment" "att" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.example.name
}
```

## Argument Reference

* `principal` - (Required) The AWS IoT Certificate ARN or Amazon Cognito Identity ID.
* `thing` - (Required) The name of the thing.

## Attributes Reference

No additional attributes are exported.

<!-- cache-key: cdktf-0.17.0-pre.15 input-ce211a0bbd3264a03351ba2d63f19981f38a8e02ba46db9ea373a55843974294 -->