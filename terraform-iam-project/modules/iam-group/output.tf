output "group_name" {
  description = "name of the iam group"
  value = aws_iam_group.this.name
}

output "group_arn" {
  description = "arn of the IAM group "
  value = aws_iam_group.this.arn
}
