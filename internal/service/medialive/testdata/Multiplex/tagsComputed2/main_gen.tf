# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "null" {}

resource "aws_medialive_multiplex" "test" {
  name               = %[1]q
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]

  multiplex_settings {
    transport_stream_bitrate                = 1000000
    transport_stream_id                     = 1
    transport_stream_reserved_bitrate       = 1
    maximum_video_buffer_delay_milliseconds = 1000
  }

  tags = {
    (var.unknownTagKey) = null_resource.test.id
    (var.knownTagKey)   = var.knownTagValue
  }
}

# acctest.ConfigAvailableAZsNoOptInExclude

data "aws_availability_zones" "available" {
  exclude_zone_ids = local.default_exclude_zone_ids
  state            = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  default_exclude_zone_ids = ["usw2-az4", "usgw1-az2"]
}

resource "null_resource" "test" {}

variable "rName" {
  description = "Name for resource"
  type        = string
  nullable    = false
}

variable "unknownTagKey" {
  type     = string
  nullable = false
}

variable "knownTagKey" {
  type     = string
  nullable = false
}

variable "knownTagValue" {
  type     = string
  nullable = false
}
