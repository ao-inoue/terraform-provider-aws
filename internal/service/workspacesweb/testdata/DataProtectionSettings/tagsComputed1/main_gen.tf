# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "null" {}

resource "aws_workspacesweb_data_protection_settings" "test" {
  display_name = "test"

  tags = {
    (var.unknownTagKey) = null_resource.test.id
  }

}
resource "null_resource" "test" {}

variable "unknownTagKey" {
  type     = string
  nullable = false
}
