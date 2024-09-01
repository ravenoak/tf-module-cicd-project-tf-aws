<!-- BEGIN_TF_DOCS -->
# tf-module-cicd-project-tf-aws
A Terraform module for enabling Terraform in a CI/CD project using AWS

## Usage
```hcl
module "terraform_roles" {
  source = "github.com/ravenoak/tf-module-cicd-project-tf-aws.git"
  project_name = "project-name"
  bucket_arn = module.remote_state.bucket_arn
  lock_table_arn = module.remote_state.table_arn
  aws_account_id = "012345678912"
  admin_role_arn = "arn:aws:iam::012345678912:user/infra-admin"
  actor_managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  oidc_trust_policy = module.oidc_trust.policy_json
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.terraform_actor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.terraform_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.terraform_oidc_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.terraform_oidc_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.terraform_state_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actor_inline_policy"></a> [actor\_inline\_policy](#input\_actor\_inline\_policy) | The inline policy for the actor role, in JSON format | `string` | `null` | no |
| <a name="input_actor_managed_policies"></a> [actor\_managed\_policies](#input\_actor\_managed\_policies) | A list of ARNs of AWS managed policies to attach to the actor role | `list(string)` | `[]` | no |
| <a name="input_actor_role_name"></a> [actor\_role\_name](#input\_actor\_role\_name) | The name of the role that will be used to implement the changes defined by Terraform. If not provided, the role will be named after the project like {project\_name}-terraform-actor | `string` | `null` | no |
| <a name="input_admin_role_arn"></a> [admin\_role\_arn](#input\_admin\_role\_arn) | The ARN of the IAM role that should have access to the Terraform roles | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID to use for creating the Terraform roles | `string` | n/a | yes |
| <a name="input_bucket_arn"></a> [bucket\_arn](#input\_bucket\_arn) | The ARN of the S3 bucket to use for storing the Terraform state | `string` | n/a | yes |
| <a name="input_lock_table_arn"></a> [lock\_table\_arn](#input\_lock\_table\_arn) | The ARN of the DynamoDB table to use for locking the Terraform state | `string` | n/a | yes |
| <a name="input_oidc_role_name"></a> [oidc\_role\_name](#input\_oidc\_role\_name) | The name of the role that will be used to assume the Terraform roles. If not provided, the role will be named after the project like {project\_name}-terraform-oidc | `string` | `null` | no |
| <a name="input_oidc_trust_policy"></a> [oidc\_trust\_policy](#input\_oidc\_trust\_policy) | The trust policy for the OIDC role, in JSON format | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project | `string` | n/a | yes |
| <a name="input_state_role_name"></a> [state\_role\_name](#input\_state\_role\_name) | The name of the role that will be used to manage the Terraform state. If not provided, the role will be named after the project like {project\_name}-terraform-state | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
