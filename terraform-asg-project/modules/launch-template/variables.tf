variable "name_prefix" {
  description  = "Prefix use for the launch template resource" 
  type = string
}

variable "instance_configs" {
  description = "Ec2 instance configuration" 
  type = map(object({
    instance_type = string
    volume_size = string
    volume_type = string
  }))
}

variable "security_group_ids" {
  description = "Security group id needed to be attached to the ec2 instance"
  type = list
}

variable "instance_profile_name" {
  description = "IAM instance profile name" 
  type = string
}

variable "user_data" {
  description = "User data script for ec2 instance" 
  type = string
}


