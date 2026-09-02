variable "user_name" {
  description = " Name of the IAM user to create "
  type        = string
  validation {
    condition     = length(trimspace(var.user_name)) > 0
    error_message = "user_name cannot be empty "
  }
}

variable "tags" {
  description = "tags to apply to the iam user"
  type        = map(string)
  default     = {}
}


