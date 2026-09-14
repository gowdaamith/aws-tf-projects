variable "vpc_id" {
  description = "ID of the vpc where the route table will be created"
  type        = string
}

variable "name" {
  description = -"Name of the route table "
  type        = string
}

variable "subnet_ids" {
  description = "List of the subnet ids to associate with the route table"
  type        = string
}

variable "internet_gateway_id" {
  description = "Id of the internet gateway used by the public route "
  type        = string
  default     = null
}


