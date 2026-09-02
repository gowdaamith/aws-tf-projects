resource "aws_iam_policy" "this" {
  name = var.policy_name
  description = var.description
  policy = var.policy_document
  tags = var.tags
}


