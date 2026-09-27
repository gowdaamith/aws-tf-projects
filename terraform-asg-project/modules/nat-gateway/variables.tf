variable "vpc_id" {
  description = "Id of the vpc"
  type = string
}

variable "public_subnet_ids" {
  description = "id of the public subnet"
  type = map(string)
}


