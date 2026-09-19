variable "aws_region" {
  description = "enter the region where you want to  creat the resource "
  type        = string
}

variable "project_name" {
  description = "enter the name of the project"
  type        = string
}

variable "environment" {
  description = "Enter the environment fo the project"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Private application subnet configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "enable_nat_gateway" {
  description = "Whether to create a nat gateway"
  type = bool
  default = true
}

variable "single_nat_gateway" {
  description = "Whether to use one nat gateway for all private subnets"
  type = bool
  default = true
}


