variable "aws_region" {
  description = "AWS region where the vpc will be created "
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the vpc"
  type        = string
}

variable "igw_name" {
  description = "Enter the name of the internet gateway "
  type        = string
}

variable "public_subnets" {
  description = "Enter the public subnet configuration "
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_app_subnets" {
  description = "Enter the private  subnet configuration "
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "database_subnets" {
  description = "Enter the private  subnet configuration "
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "traffic_type" {
  description = "Enter the type of the traffic you want to capture from the vpc flow logs"
  type        = string
  validation {
    condition = contains(
      ["ACCEPT", "REJECT", "ALL"],
      var.traffic_type
    )

    error_message = "traffic_type must be ACCEPT, REJECT, or ALL."
  }

}


