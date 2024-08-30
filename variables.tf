variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket to use for storing the Terraform state"
  type        = string
  validation {
    condition     = can(regex("arn:aws:s3:::.*", var.bucket_arn))
    error_message = "Bucket ARN must be in the format arn:aws:s3:::bucket-name"
  }
}

variable "lock_table_arn" {
  description = "The ARN of the DynamoDB table to use for locking the Terraform state"
  type        = string
  validation {
    condition     = can(regex("arn:aws:dynamodb:.*:table/.*", var.lock_table_arn))
    error_message = "Lock table ARN must be in the format arn:aws:dynamodb:region:account-id:table/table-name"
  }
}

variable "oidc_role_name" {
  description = "The name of the role that will be used to assume the Terraform roles. If not provided, the role will be named after the project like {project_name}-terraform-oidc"
  type        = string
  default     = null
}

variable "actor_role_name" {
  description = "The name of the role that will be used to implement the changes defined by Terraform. If not provided, the role will be named after the project like {project_name}-terraform-actor"
  type        = string
  default     = null
}

variable "state_role_name" {
  description = "The name of the role that will be used to manage the Terraform state. If not provided, the role will be named after the project like {project_name}-terraform-state"
  type        = string
  default     = null
}

variable "aws_account_id" {
  description = "The AWS Account ID to use for creating the Terraform roles"
  type        = string
  validation {
    condition     = length(var.aws_account_id) == 12
    error_message = "AWS Account ID must be 12 digits long"
  }
}

variable "admin_role_arn" {
  description = "The ARN of the IAM role that should have access to the Terraform roles"
  type        = string
  validation {
    condition     = can(regex("arn:aws:iam::.*:(role|user)/.*", var.admin_role_arn))
    error_message = "Admin role ARN must be in the format arn:aws:iam::account-id:role/role-name"
  }
}

variable "actor_managed_policies" {
  description = "A list of ARNs of AWS managed policies to attach to the actor role"
  type        = list(string)
  validation {
    condition     = alltrue([for x in var.actor_managed_policies : can(regex("arn:aws:iam::.*:policy/.*", x))])
    error_message = "Managed policy ARNs must be in the format arn:aws:iam::account-id:policy/policy-name"
  }
  default = []
}

variable "actor_inline_policy" {
  description = "The inline policy for the actor role, in JSON format"
  type        = string
  validation {
    condition     = can(jsondecode(var.actor_inline_policy))
    error_message = "Inline policy must be valid JSON"
  }
  default = null
}

variable "oidc_trust_policy" {
  description = "The trust policy for the OIDC role, in JSON format"
  type        = string
  validation {
    condition     = can(jsondecode(var.oidc_trust_policy))
    error_message = "Trust policy must be valid JSON"
  }
}
