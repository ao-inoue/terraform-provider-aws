---
subcategory: "Lightsail"
layout: "aws"
page_title: "AWS: aws_lightsail_container_service"
description: |- 
  Provides a resource to manage Lightsail container service
---


<!-- Please do not edit this file, it is generated. -->
# Resource: aws_lightsail_container_service

An Amazon Lightsail container service is a highly scalable compute and networking resource on which you can deploy, run,
and manage containers. For more information, see
[Container services in Amazon Lightsail](https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-container-services).

~> **Note:** For more information about the AWS Regions in which you can create Amazon Lightsail container services,
see ["Regions and Availability Zones in Amazon Lightsail"](https://lightsail.aws.amazon.com/ls/docs/overview/article/understanding-regions-and-availability-zones-in-amazon-lightsail).

~> **NOTE:** You must create and validate an SSL/TLS certificate before you can use `public_domain_names` with your container service. For more information, see
[Enabling and managing custom domains for your Amazon Lightsail container services](https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-creating-container-services-certificates).

## Example Usage

### Basic Usage

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.lightsail_container_service import LightsailContainerService
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name):
        super().__init__(scope, name)
        LightsailContainerService(self, "my_container_service",
            is_disabled=False,
            name="container-service-1",
            power="nano",
            scale=1,
            tags={
                "foo1": "bar1",
                "foo2": ""
            }
        )
```

### Public Domain Names

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.lightsail_container_service import LightsailContainerService
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name, *, name, power, scale):
        super().__init__(scope, name)
        LightsailContainerService(self, "my_container_service",
            public_domain_names=LightsailContainerServicePublicDomainNames(
                certificate=[LightsailContainerServicePublicDomainNamesCertificate(
                    certificate_name="example-certificate",
                    domain_names=["www.example.com"]
                )
                ]
            ),
            name=name,
            power=power,
            scale=scale
        )
```

### Private Registry Access

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import Fn, Token, TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.data_aws_iam_policy_document import DataAwsIamPolicyDocument
from imports.aws.ecr_repository_policy import EcrRepositoryPolicy
from imports.aws.lightsail_container_service import LightsailContainerService
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name, *, name, power, scale):
        super().__init__(scope, name)
        default_var = LightsailContainerService(self, "default",
            private_registry_access=LightsailContainerServicePrivateRegistryAccess(
                ecr_image_puller_role=LightsailContainerServicePrivateRegistryAccessEcrImagePullerRole(
                    is_active=True
                )
            ),
            name=name,
            power=power,
            scale=scale
        )
        data_aws_iam_policy_document_default = DataAwsIamPolicyDocument(self, "default_1",
            statement=[DataAwsIamPolicyDocumentStatement(
                actions=["ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer"],
                effect="Allow",
                principals=[DataAwsIamPolicyDocumentStatementPrincipals(
                    identifiers=[
                        Token.as_string(
                            Fn.lookup_nested(default_var.private_registry_access, ["0", "ecr_image_puller_role", "0", "principal_arn"
                            ]))
                    ],
                    type="AWS"
                )
                ]
            )
            ]
        )
        # This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.
        data_aws_iam_policy_document_default.override_logical_id("default")
        aws_ecr_repository_policy_default = EcrRepositoryPolicy(self, "default_2",
            policy=Token.as_string(data_aws_iam_policy_document_default.json),
            repository=Token.as_string(aws_ecr_repository_default.name)
        )
        # This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.
        aws_ecr_repository_policy_default.override_logical_id("default")
```

## Argument Reference

This resource supports the following arguments:

* `name` - (Required) The name for the container service. Names must be of length 1 to 63, and be
  unique within each AWS Region in your Lightsail account.
* `power` - (Required) The power specification for the container service. The power specifies the amount of memory,
  the number of vCPUs, and the monthly price of each node of the container service.
  Possible values: `nano`, `micro`, `small`, `medium`, `large`, `xlarge`.
* `scale` - (Required) The scale specification for the container service. The scale specifies the allocated compute
  nodes of the container service.
* `is_disabled` - (Optional) A Boolean value indicating whether the container service is disabled. Defaults to `false`.
* `public_domain_names` - (Optional) The public domain names to use with the container service, such as example.com
  and www.example.com. You can specify up to four public domain names for a container service. The domain names that you
  specify are used when you create a deployment with a container configured as the public endpoint of your container
  service. If you don't specify public domain names, then you can use the default domain of the container service.
  Defined below.
* `private_registry_access` - (Optional) An object to describe the configuration for the container service to access private container image repositories, such as Amazon Elastic Container Registry (Amazon ECR) private repositories. See [Private Registry Access](#private-registry-access) below for more details.
* `tags` - (Optional) Map of container service tags. To create a key-only tag, use an empty string as the value. To tag at launch, specify the tags in the Launch Template. If
  configured with a provider
  [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block)
  present, tags with matching keys will overwrite those defined at the provider-level.

### Private Registry Access

The `private_registry_access` block supports the following arguments:

* `ecr_image_puller_role` - (Optional) Describes a request to configure an Amazon Lightsail container service to access private container image repositories, such as Amazon Elastic Container Registry (Amazon ECR) private repositories. See [ECR Image Puller Role](#ecr-image-puller-role) below for more details.

### ECR Image Puller Role

The `ecr_image_puller_role` blocks supports the following arguments:

* `is_active` - (Optional) A Boolean value that indicates whether to activate the role. The default is `false`.

## Attribute Reference

This resource exports the following attributes in addition to the arguments above:

* `arn` - The Amazon Resource Name (ARN) of the container service.
* `availability_zone` - The Availability Zone. Follows the format us-east-2a (case-sensitive).
* `id` - Same as `name`.
* `power_id` - The ID of the power of the container service.
* `principal_arn`- The principal ARN of the container service. The principal ARN can be used to create a trust
  relationship between your standard AWS account and your Lightsail container service. This allows you to give your
  service permission to access resources in your standard AWS account.
* `private_domain_name` - The private domain name of the container service. The private domain name is accessible only
  by other resources within the default virtual private cloud (VPC) of your Lightsail account.
* `region_name` - The AWS Region name.
* `resource_type` - The Lightsail resource type of the container service (i.e., ContainerService).
* `state` - The current state of the container service.
* `tags_all` - A map of tags assigned to the resource, including those inherited from the provider
  [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).
* `url` - The publicly accessible URL of the container service. If no public endpoint is specified in the
  currentDeployment, this URL returns a 404 response.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30m`)
* `update` - (Default `30m`)
* `delete` - (Default `30m`)

## Import

In Terraform v1.5.0 and later, use an [`import` block](https://developer.hashicorp.com/terraform/language/import) to import Lightsail Container Service using the `name`. For example:

```python
# DO NOT EDIT. Code generated by 'cdktf convert' - Please report bugs at https://cdk.tf/bug
from constructs import Construct
from cdktf import TerraformStack
#
# Provider bindings are generated by running `cdktf get`.
# See https://cdk.tf/provider-generation for more details.
#
from imports.aws.lightsail_container_service import LightsailContainerService
class MyConvertedCode(TerraformStack):
    def __init__(self, scope, name):
        super().__init__(scope, name)
        LightsailContainerService.generate_config_for_import(self, "myContainerService", "container-service-1")
```

Using `terraform import`, import Lightsail Container Service using the `name`. For example:

```console
% terraform import aws_lightsail_container_service.my_container_service container-service-1
```

<!-- cache-key: cdktf-0.20.8 input-90e66b805c0c5c54ba438fac7f6f5d44f40925e3bfe5dab6c9e21c151ef5e189 -->