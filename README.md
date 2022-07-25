<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/ecs_task_definition) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/resources/lb_target_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/caller_identity) | data source |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/security_group) | data source |
| [aws_subnet.private1](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/subnet) | data source |
| [aws_subnet.private2](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/subnet) | data source |
| [aws_subnet.public1](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/subnet) | data source |
| [aws_subnet.public2](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/subnet) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/4.22.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_subnet1"></a> [private\_subnet1](#input\_private\_subnet1) | 변수값 입력 | `string` | `` | no |
| <a name="input_private_subnet2"></a> [private\_subnet2](#input\_private\_subnet2) | 변수값 입력 | `string` | `` | no |
| <a name="input_public_subnet1"></a> [public\_subnet1](#input\_public\_subnet1) | 변수값 입력 | `string` | `` | no |
| <a name="input_public_subnet2"></a> [public\_subnet2](#input\_public\_subnet2) | 변수값 입력 | `string` | `` | no |
| <a name="input_sg_id"></a> [sg\_id](#input\_sg\_id) | 변수값 입력 | `string` | `` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | 변수값 입력 | `string` | `` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->