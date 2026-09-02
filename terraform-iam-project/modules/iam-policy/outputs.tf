output "policy_arn" {
  description = "ARN of the IAM POLICY"
  value = aws_iam_policy.this.arn
}

output "policy_id" {
  description = "ID of the IAM policy"
  value = aws_iam_policy.this.id 
}

output "policy_name" {
  description = "Policy name "
  value = aws_iam_policy.this.name
}

