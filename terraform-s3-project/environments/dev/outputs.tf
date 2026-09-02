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


