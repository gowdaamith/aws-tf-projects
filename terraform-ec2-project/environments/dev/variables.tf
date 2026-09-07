variable "aws_region" {
  description = "Enter the region where you want to create the resources"
  type        = string
}

variable "instance_type" {
  description = "Enter the instance type you want"
  type        = string
}


variable "environment" {
  description = "Enter the environment in which we are working"
  type        = string
}

variable "vpc_cidr" {
  description = "Enter the cidr block for the dev vpc"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to access SSH"
  type        = string

}
