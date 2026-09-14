variable "name" {
  description =  "Enter the name of the nat gateway" 
  type = string
}

variable "public_subnet_id" {
  description = "Id of the public subnet where the nat gateway will be created "
  type = string 
}


