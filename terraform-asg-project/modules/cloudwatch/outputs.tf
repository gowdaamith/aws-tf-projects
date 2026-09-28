output "scaling_policy_arn" {
  description = "ARN of the Auto Scaling target tracking policy"
  value       = aws_autoscaling_policy.target_tracking.arn
}
