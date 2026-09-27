variable "aws_region" {
  description = "Enter the region where you want to create the resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Enter the name of the project"
  type        = string
}

variable "environment" {
  description = "Enter the name of the current environment"
  type        = string
}

variable "cidr_range" {
  description = "Enter the cidr range of the vpc createed"
  type        = string

}

variable "subnets" {
  description = "Enter the subnets information you want to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    subnet_type       = string
  }))
}


