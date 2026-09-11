variable "ami_id" {
  description = "enter the ami id of the instance"
  type        = string
}

variable "instance_type" {
  description = "enter the instance type "
  type        = string
}

variable "subnet_id" {
  description = "enter the subnet id of the subnet where you want to place the instance "
  type        = string
}

variable "security_group_id" {
  description = "enter the security groups id that are associated with this instance "
  type        = list(string)
}

variable "instance_name" {
  description = "name tag for the ec2 instance "
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile attached to the ec2 instance "
  type        = string
}

variable "user_data" {
  description = "user data script used to bootstrap the ec2 instance "
  type        = string
}

variable "data_volume_size" {
  description = "Size of the additional EBS data volume is Gi"
  type = number 
}

variable "data_volume_type" {
  description = "Type of the additional EBS data volume" 
  type = string 
  default = "gp3"
}


