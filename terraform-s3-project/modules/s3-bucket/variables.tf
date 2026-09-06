variable "bucket_name" {
  description = "Enter a unique s3 bucket name"
  type=string
  validation {
    condition = length(var.bucket_name) >= 3
    error_message = "enter a valid bucket name"
  }
}

variable "environment_name" {
  description = "Enter the name of the environment "
  type = string
  validation {
    condition = contains (["dev","prod","staging"],var.environment_name)
    error_message = "environment must be one of dev prod ro staging "
  }
}

variable "transition_to_ia_days" {
  description = "Number of days defore  objects transition to standard IA "
  type = number
}

variable "transition_to_glacier_days" {
  description = "Number of days before objects transition to Glacier"
  type =  number
}
variable "expiration_days" {
  description = "Number of day before object get deleted  "
  type = number 
}

