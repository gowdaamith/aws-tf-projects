variable "project_name" {
  description = "Enter the name of the project"
  type = string
}

variable "environment" {
  description = "Enter the environment of the project"
  type = string
}

variable "vpc_id" {
  description = "Enter the vpc id of the project"
  type = string
}

variable "vpc_cidr" {
  description = "Enter the vpc cidr of the project"
  type = string
}

variable "public_subnet_ids" {
  description = "Enter the public subnets to associate the nacl with"
  type = map(string)
}

variable "private_subnet_ids" {
  description = "Enter the private subnet to associate with the nacl "
  type = map(string)
}


