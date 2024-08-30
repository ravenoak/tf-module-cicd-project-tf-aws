data "aws_iam_policy_document" "terraform_oidc_trust" {
  statement {
    principals {
      identifiers = [aws_iam_role.terraform_oidc.arn]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
  statement {
    principals {
      identifiers = [var.admin_role_arn]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "terraform_oidc_permissions" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/${var.actor_role_name}",
      "arn:aws:iam::${var.aws_account_id}:role/${var.state_role_name}"
    ]
  }
}

data "aws_iam_policy_document" "terraform_state_policy" {
  statement {
    sid = "StateLock"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      var.lock_table_arn,
    ]
  }
  statement {
    sid = "StateBucket"
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      var.bucket_arn,
    ]
  }
  statement {
    sid = "StateBucketContents"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${var.bucket_arn}/*",
    ]
  }
}
