---
subcategory: "Network Manager"
layout: "aws"
page_title: "AWS: aws_networkmanager_link"
description: |-
  Creates a link for a site.
---

# Resource: aws_networkmanager_link

Creates a link for a site.

## Example Usage

```terraform
resource "aws_networkmanager_link" "example" {
  global_network_id = aws_networkmanager_global_network.example.id
  site_id           = aws_networkmanager_site.example.id

  bandwidth {
    upload_speed   = 10
    download_speed = 50
  }

  provider_name = "MegaCorp"
}
```

## Argument Reference

The following arguments are supported:

* `bandwidth` - (Required) The upload speed and download speed in Mbps. Documented below.
* `description` - (Optional) A description of the link.
* `globalNetworkId` - (Required) The ID of the global network.
* `providerName` - (Optional) The provider of the link.
* `siteId` - (Required) The ID of the site.
* `tags` - (Optional) Key-value tags for the link. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `type` - (Optional) The type of the link.

The `bandwidth` object supports the following:

* `downloadSpeed` - (Optional) Download speed in Mbps.
* `uploadSpeed` - (Optional) Upload speed in Mbps.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Link Amazon Resource Name (ARN).
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsNetworkmanagerLink` can be imported using the link ARN, e.g.

```
$ terraform import aws_networkmanager_link.example arn:aws:networkmanager::123456789012:link/global-network-0d47f6t230mz46dy4/link-444555aaabbb11223
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-f9826a575b6176d48e644a610ef863ca4da725d0abd5b393a794410b7f235bfb -->