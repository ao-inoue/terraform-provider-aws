---
subcategory: "User Notifications"
layout: "aws"
page_title: "AWS: aws_notifications_event_rule"
description: |-
  Terraform resource for managing an AWS User Notifications Event Rule.
---

<!-- Please do not edit this file, it is generated. -->
# Resource: aws_notifications_event_rule

Terraform resource for managing an AWS User Notifications Event Rule.

## Example Usage

### Basic Usage

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import Fn, Token, TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.notifications_event_rule import NotificationsEventRule
from imports.aws.notifications_notification_configuration import NotificationsNotificationConfiguration
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name):
        super().__init__(scope, name)
        example = NotificationsNotificationConfiguration(self, "example",
            description="example configuration",
            name="example"
        )
        aws_notifications_event_rule_example = NotificationsEventRule(self, "example_1",
            event_pattern=Token.as_string(
                Fn.jsonencode({
                    "detail": {
                        "state": {
                            "value": ["ALARM"]
                        }
                    }
                })),
            event_type="CloudWatch Alarm State Change",
            notification_configuration_arn=example.arn,
            regions=["us-east-1", "us-west-2"],
            source="aws.cloudwatch"
        )
        # This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.
        aws_notifications_event_rule_example.override_logical_id("example")
```

## Argument Reference

The following arguments are required:

* `event_type` - (Required) Type of event to match. Must be between 1 and 128 characters, and match the pattern `([a-zA-Z0-9 \-\(\)])+`.
* `notification_configuration_arn` - (Required) ARN of the notification configuration to associate with this event rule. Must match the pattern `arn:aws:notifications::[0-9]{12}:configuration/[a-z0-9]{27}`.
* `regions` - (Required) Set of AWS regions where the event rule will be applied. Each region must be between 2 and 25 characters, and match the pattern `([a-z]{1,2})-([a-z]{1,15}-)+([0-9])`.
* `source` - (Required) Source of the event. Must be between 1 and 36 characters, and match the pattern `aws.([a-z0-9\-])+`.

The following arguments are optional:

* `event_pattern` - (Optional) JSON string defining the event pattern to match. Maximum length is 4096 characters.
* `timeouts` - (Optional) Configuration block specifying how long to wait for the event rule to be created, updated, or deleted.

## Attribute Reference

This resource exports the following attributes in addition to the arguments above:

* `arn` - ARN of the Event Rule.

## Import

In Terraform v1.5.0 and later, use an [`import` block](https://developer.hashicorp.com/terraform/language/import) to import User Notifications Event Rule using the `arn`. For example:

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.notifications_event_rule import NotificationsEventRule
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name):
        super().__init__(scope, name)
        NotificationsEventRule.generate_config_for_import(self, "example", "arn:aws:notifications::123456789012:configuration/abc123def456ghi789jkl012mno345/rule/abc123def456ghi789jkl012mno345")
```

Using `terraform import`, import User Notifications Event Rule using the `arn`. For example:

```console
% terraform import aws_notifications_event_rule.example arn:aws:notifications::123456789012:configuration/abc123def456ghi789jkl012mno345/rule/abc123def456ghi789jkl012mno345
```

<!-- cache-key: cdktf-0.20.8 input-65c919033926d3754a2ad734c69d9befe1039510f9606ec586be4c7b3922edbe -->