output "iam_user_name" {
  description = "this is the name of the iam user that we have created "
  value       = module.developer_user.user_name
}


output "iam_user_arn" {
  description = "this is the arn of the iam user that we have created "
  value       = module.developer_user.user_arn
}

output "iam_group_name" {
  description = "this is the name of the group that we have craeted "
  value       = module.developer_group.group_name
}

output "iam_group_arn" {
  description = "this is the arn of the group that we have craeted "
  value       = module.developer_group.group_arn
}


output "s3_policy_arn" {
  description = "this is the arn of the  s3  policy we have created "
  value       = module.s3_read_policy.policy_arn
}

output "cloud_watch_arn" {
  description = "this is the arn of the cloudwatch   policy we have created"
  value       = module.cloudwatch_read_policy.policy_arn
}

output "user_policy_arn" {
  description = "this is the arn of the user policy we have created "
  value       = module.user_policy.policy_arn
}
