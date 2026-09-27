variable "vpc_id" {
  description = "enter the vpc id you want to conenct the subnet with" 
  type = string
}

variable "subnets" {
  description = "subnet configuration" 
  type = map(object({
    cidr_block = string
    availability_zone = string 
    subnet_type = string
  }))
}




