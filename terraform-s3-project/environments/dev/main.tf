module "s3_bucket" {
  source           = "../../modules/s3-bucket"
  bucket_name      = var.bucket_name
  environment_name = var.environment_name
  transition_to_ia_days = var.transition_to_ia_days
  transition_to_glacier_days = var.transition_to_ia_days
  expiration_days  = var.expiration_days
}

module "s3_security" {
  source     = "../../modules/s3-security"
  bucket_id  = module.s3_bucket.bucket_id
  bucket_arn = module.s3_bucket.bucket_arn
}


