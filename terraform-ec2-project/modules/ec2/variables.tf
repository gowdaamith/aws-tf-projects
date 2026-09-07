variable "ami_id" {
  description = "enter the ami id of the instance"
  type = string
}

variable "instance_type" {
  description = "enter the instance type "
  type = string
}

variable "subnet_id" {
  description = "enter the subnet id of the subnet where you want to place the instance "
  type = string
}

variable "security_group_id" {
  description = "enter the security groups id that are associated with this instance "
  type = list(string)
}

variable "instance_name" {
  description = "name tag for the ec2 instance "
  type = string
}

variable "environment" {
  description = "Deployment environment" 
  type = string
}


