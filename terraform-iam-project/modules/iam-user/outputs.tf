output "user_name" {
  description = "name of the IAM user"
  value       = aws_iam_user.this.name
}

output "user_arn" {
  description = "arn of the iam user"
  value       = aws_iam_user.this.arn
}


