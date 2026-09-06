output "log_bucket_id" {
  description = "ID of the S3 logging bucket"
  value       = aws_s3_bucket.logs.id
}

output "log_bucket_arn" {
  description = "ARN of the S3 logging bucket"
  value       = aws_s3_bucket.logs.arn
}
