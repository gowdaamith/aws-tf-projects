variable "bucket_name"{
  description = "enter the bucket name for using it to store access logs"
  type = string 
  validation {
    condition = length(var.bucket_name) >= 3
    error_message = "enter a valid s3 bucket name " 
  }
}


