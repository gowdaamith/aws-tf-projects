variable "policy_name" {
  description = "Name of the IAM policy"
  type = string
  validation {
    condition =  length(trimspace(var.policy_name)) > 0
    error_message = "name of the policy cann't be zero"
  }
}

variable "description" {
  description = "Enter the description of the policy"
  type = string
  validation {
    condition =  length(trimspace(var.description)) > 0
    error_message = "name of the policy cann't be zero"
  }
}

variable "policy_document" {
  description = "enter the path of the json documentts"
  type = string
  validation {
    condition     = length(trimspace(var.policy_document)) > 0
    error_message = "policy_document must not be empty."
  }
}

variable "tags" {
  description = "enter the tags of the variable "
  type = map(string)
  default = {}
}
