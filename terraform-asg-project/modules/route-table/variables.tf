variable "vpc_id" {
  description = "ID of the vpc"
  type = string
}

variable "internet_gateway_id" {
  description = "ID of the internet gateway"
  type = string
}

variable "public_subnet_ids" {
  description = "Map of the public subnet name to subnet ids"
  type = map(string)
}

variable "private_subnet_ids" {
  description = "Map of private subnet name to subnet ids"
  type = map(string)
}


variable "database_subnet_ids" {
  description = "Map of the database subnet names to subnet Ids"
  type = map(string)
}

variable "nat_gateway_ids" {
  description ="Map of the private subnet names to nat gateway IDS"
  type = map(string)
  default = {}
}
