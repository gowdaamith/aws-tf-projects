variable "vpc_id" {
  description = "Enter the vpc id you want to attach the subnet to "
  type        = string
}

variable "subnets" {
  description = "Enter the cidr block of the subnet"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "subnet_tier" {
  description = "enter the tier of the subnet"
  type        = string
  validation {
    condition     = contains(["public", "private-app", "database"], var.subnet_tier)
    error_message = "subnet_tier must be public ,private-app, or database"
  }
}

variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

