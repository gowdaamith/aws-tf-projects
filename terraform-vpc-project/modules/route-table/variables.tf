variable "vpc_id" {
  description = "Enter the VPC id"
  type = string
}

variable "name" {
  description = "Enter the name of the route table" 
  type = string
}

variable "subnet_ids" {
  description = "Enter the subnet id to associate the route table with"
  type =list(string)
}

variable "internet_gateway_id" {
  description = "ID of the internet gateway ussed by the public route"
  type = string
  default = null 
}


