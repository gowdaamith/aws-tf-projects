variable "group_name" {
  description = "enter the group name " 
  type = string
  validation {
    condition = length(trimspace(var.group_name)) > 0
    error_message = "group_name must not be empty "
  }
}

