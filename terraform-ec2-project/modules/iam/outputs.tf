output "instance_profile_name" {
  description = "IAM instance profile name for ec2"
  value       = aws_iam_instance_profile.this.name
}

output "role_name" {
  description = "IAM role name for ec2"
  value       = aws_iam_role.this.name
}


