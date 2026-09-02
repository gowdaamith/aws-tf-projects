resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = {
    name = var.bucket_name
    environment = var.environment_name
    managedby = "terraform"

  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket  = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    id = "object-lifecycle"
    status = "Enabled"
    filter {
      prefix = ""
    }
    transition {
      days = var.transition_to_ia_days
      storage_class = "STANDARD_ID"
    }
    transition {
      days =  var.transition_to_glacier_days
      storage_class = "GLACIER"
    }
    expiration {
      days = var.expiration_days
    }
    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}



