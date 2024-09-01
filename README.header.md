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
