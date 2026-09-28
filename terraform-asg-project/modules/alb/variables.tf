variable "prefix_name" { 
  description = "Enter the name of the load balancer"
  type = string
}

variable "vpc_id" {
  description = "Id of the vpc"
  type = string
}


variable "load_balancer_type" {
  description = "Enter the type of the load balancer"
  type = string
}

variable "public_subnet_ids" {
  description = "Enter the subnet where the load balancer nodes to be placed"
  type = map(string)
}

variable "security_group_ids" {
  description = "Enter the security groups to be attached to the lb"
  type = string
}


