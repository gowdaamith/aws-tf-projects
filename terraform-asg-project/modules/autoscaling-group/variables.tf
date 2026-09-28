variable "name_prefix" {
  description = "Prefix used for Auto Scaling Group resources"
  type = string
}

variable "launch_template_id" {
  description = "ID of the Launch Template"
  type        = string
}

variable "launch_template_version" {
  description = "Version of the Launch Template"
  type        = string
}

variable "private_subnet_ids" {
  description = "Map of private application subnet names to subnet IDs"
  type        = map(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
}




