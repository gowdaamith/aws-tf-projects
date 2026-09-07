variable "vpc_cidr" {
  description  = "cidr block for the vpc"
  type  = string 
}

variable "public_subnet_cidr" {
  description = "cidr block of the public subnet"
  type = string 
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type = string
}

variable "environment" {
  description = "environment name"
  type = string 
}

	
