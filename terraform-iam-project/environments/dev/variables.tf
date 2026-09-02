variable "aws_region" {
  description = "this is the region where the resource will be created "
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "this is the name of the project"
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "Project_name must not be empty"

  }
}

variable "environment" {
  description = "Deployment Environment, Must be dev,staging or prod "
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of : dev,staging or prod"

  }
}

variable "iam_user_name" {
  description = "enter the name of the iam user "
  type        = string
  validation {
    condition     = length(trimspace(var.iam_user_name)) > 0
    error_message = " iam_user_name cannot be empty"

  }
}
variable "iam_group_name" {
  description = "enter the name of the group "
  type        = string
  validation {
    condition     = length(trimspace(var.iam_group_name)) > 0
    error_message = "iam_group_name cannot be empty"

  }
}
