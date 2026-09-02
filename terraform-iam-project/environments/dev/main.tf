module "developer_user" {
  source    = "../../modules/iam-user"
  user_name = var.iam_user_name
  tags      = local.common_tags
}
moved {
  from = aws_iam_user.developer
  to   = module.developer_user.aws_iam_user.this
}

module "developer_group" {
  source     = "../../modules/iam-group"
  group_name = var.iam_group_name
}
moved {
  from = aws_iam_group.developers
  to   = module.developer_group.aws_iam_group.this
}


module "user_policy" {
  source          = "../../modules/iam-policy"
  policy_name     = "${local.name_prefix}_user_policy"
  description     = "user policy"
  policy_document = file("${path.module}/policies/user-policy.json")
  tags            = local.common_tags
}

moved {
  from = aws_iam_policy.user_policy
  to   = module.user_policy.aws_iam_policy.this
}



resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = module.developer_user.user_name
  policy_arn = module.user_policy.policy_arn
}

module "s3_read_policy" {
  source          = "../../modules/iam-policy"
  policy_name     = "${local.name_prefix}_s3_read"
  description     = "Read-only access to s3"
  policy_document = file("${path.module}/policies/s3-read-policy.json")
  tags            = local.common_tags
}

moved {
  from = aws_iam_policy.s3_read_policy
  to   = module.s3_read_policy.aws_iam_policy.this
}



resource "aws_iam_group_policy_attachment" "s3_read" {
  group      = module.developer_group.group_name
  policy_arn = module.s3_read_policy.policy_arn
}



module "cloudwatch_read_policy" {
  source          = "../../modules/iam-policy"
  description     = "cloudwatch read access"
  policy_name     = "${local.name_prefix}_cloudwatch_read"
  policy_document = file("${path.module}/policies/cloudwatch-read-policy.json")
  tags            = local.common_tags
}


moved {
  from = aws_iam_policy.cloudwatch_read_policy
  to   = module.cloudwatch_read_policy.aws_iam_policy.this
}



resource "aws_iam_group_policy_attachment" "cloudwatch_read" {
  group      = module.developer_group.group_name
  policy_arn = module.cloudwatch_read_policy.policy_arn
}


resource "aws_iam_user_group_membership" "developers" {
  user = module.developer_user.user_name

  groups = [
    module.developer_group.group_name,
  ]
}


