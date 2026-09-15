output "bucket_id" {
  description = "Id of the s3  logging bucket"
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "Arn of the s3 logging bucket"
  value = aws_s3_bucket.this.arn
}

