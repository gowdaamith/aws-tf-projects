variable "project_name" {
  description = "enter the name of the project"
  type = string
}

variable "environment" {
  description = "Enter the environment of the project"
  type = string
}

variable "vpc_cidr" {
  description = "Enter the cidr fo the vpc"
  type = string
}

variable "public_subnets" {
  description = "Enter the cidr block of the public  subnet"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Enter the cidr block of the private subnet"
  type = map(object({
    cidr_block = string
    availability_zone = string 
  }))
}


