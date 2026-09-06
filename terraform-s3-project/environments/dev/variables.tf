variable "bucket_name" {
  description = "Development s3 bucket name"
  type        = string
  validation {
    condition     = length(var.bucket_name) >= 3
    error_message = "enteer a valid s3 bucket name"
  }
}
variable "environment_name" {
  description = "enter the environment name "
  type        = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment_name)
    error_message = "enter a valid environment name "
  }
}

variable "aws_region" {
  description = "enther the region where you want to create the resources"
  type        = string
  default     = "ap-south-1"
}

variable "transition_to_ia_days" {
  description = "Dev Standard IA transition period "
  type = number 
}

variable "transition_to_glacier_days" {
  description = "Dev Glacier transition  period"
  type = number 
}

variable "expiration_days" {
  description  = "Dev object expiration period"
  type = number 

}

