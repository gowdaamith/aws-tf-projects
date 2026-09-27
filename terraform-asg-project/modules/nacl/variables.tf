variable "vpc_id" {
  description ="Enter the vpc if where the nacl to be created"
  type = string
}

variable "public_subnet_ids" {
  description = "map of public subnet name and public subnet ids"
  type =  map(string)
}

variable "private_subnet_ids" {
  description = "map of private  subnet name and private  subnet ids"
  type =  map(string)
}


variable "database_subnet_ids" {
  description = "map of database subnet name and database subnet ids"
  type = map(string) 
}



