output "bucket_id" {
  description = "this is the id of the s3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "bucket_arn" {
  description = "This is the arn of the s3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "bucket_name" {
  description = "this is the name of the s3 bucket "
  value       = module.s3_bucket.bucket_name
}

output "log_bucket_name" {
  description = "this is the bucket name of the s3 wwhich store the log"
  value = module.s3_logging.bucket_id
}

output "log_bucket_arnr" {
  description ="s3 logging bucket arn"
  value - module.s3_logging.log_bucket_arn
}
