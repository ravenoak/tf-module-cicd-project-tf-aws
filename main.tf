resource "aws_iam_role" "terraform_oidc" {
  assume_role_policy = var.oidc_trust_policy
  name               = local.oidc_role_name
  inline_policy {
    name   = "AssumeTerraformRoles"
    policy = data.aws_iam_policy_document.terraform_oidc_permissions.json
  }
}

resource "aws_iam_role" "terraform_state" {
  assume_role_policy = data.aws_iam_policy_document.terraform_oidc_trust.json
  name               = local.state_role_name
  inline_policy {
    name   = "TerraformStateManagement"
    policy = data.aws_iam_policy_document.terraform_state_policy.json
  }
}

resource "aws_iam_role" "terraform_actor" {
  assume_role_policy  = data.aws_iam_policy_document.terraform_oidc_trust.json
  name                = local.actor_role_name
  managed_policy_arns = var.actor_managed_policies
  inline_policy {
    name   = "TerraformActorPolicy"
    policy = var.actor_inline_policy
  }
}
