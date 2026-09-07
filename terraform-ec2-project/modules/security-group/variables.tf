variable "vpc_id" {
  description = "vpc id where the security  group will be created "
  type = string
}

variable "environment" {
  description  = "Environment name"
  type = string
}

variable "allow_ssh_cidr" {
  description = "CIDR block allowed to access the SSH"
  type =string
}
