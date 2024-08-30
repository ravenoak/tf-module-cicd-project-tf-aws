locals {
  project_name    = replace(lower(var.project_name), "[^a-z0-9]", "-")
  oidc_role_name  = var.oidc_role_name != null ? var.oidc_role_name : "${local.project_name}-terraform-oidc"
  actor_role_name = var.actor_role_name != null ? var.actor_role_name : "${local.project_name}-terraform-actor"
  state_role_name = var.state_role_name != null ? var.state_role_name : "${local.project_name}-terraform-state"
}