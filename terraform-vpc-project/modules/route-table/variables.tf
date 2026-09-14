variable "vpc_id" {
  description = "ID of the vpc where the route table will be created"
  type        = string
}

variable "name" {
  description = "Name of the route table "
  type        = string
}

variable "subnet_ids" {
  description = "List of the subnet ids to associate with the route table"
  type        = map(string)
}

variable "internet_gateway_id" {
  description = "Id of the internet gateway used by the public route "
  type        = string
  default     = null
}

variable "create_internet_route" {
  description = "whether to create the default route to the internet gateway or not" 
  type = bool
  default = false
}

variable "nat_gateway_id" {
  description = "Id of the nat gateway used by the private route"
  type = string 
  default = null
}

variable "create_nat_route" {
  description = "Whether to create a default route to the nat gateaway"
  type = bool
  default = false
}


