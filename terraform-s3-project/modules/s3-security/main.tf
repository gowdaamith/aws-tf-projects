resource "aws_s3_bucket_public_access_block" "this" {
  bucket = var.bucket_id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket  = var.bucket_id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "denyInsecuretransport"
    effect = "Deny"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = [
      var.bucket_arn,
      "${var.bucket_arn}/*"
    ]
    condition {
      test = "Bool"
      variable = "aws:bucket_policy"
      values = ["false"]
    }
  }
}
resource "aws_s3_bucket_policy" "secure_transport" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.bucket_policy.json
    
}


