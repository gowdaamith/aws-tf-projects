output "bucket_name" {
  description = "this is the name of the bucket  that we will be using"
  value = aws_s3_bucket.this.bucket
}
output "bucket_logging" {
  description = "this is the name of the logging bucket we will be using "
  value = aws_s3_bucket.logging.bucket
}


