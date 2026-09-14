variable "vpc_id" {
  description = "ID of the VPC for which flow logs will be enabled"
  type        = string
}

variable "name" {
  description = "Name of the VPC flow log"
  type        = string
}

variable "traffic_type" {
  description = "Type of traffic to capture"
  type        = string

  validation {
    condition = contains(
      ["ACCEPT", "REJECT", "ALL"],
      var.traffic_type
    )

    error_message = "traffic_type must be ACCEPT, REJECT, or ALL."
  }
}

variable "log_destination" {
  description = "ARN of the destination where VPC Flow Logs will be delivered"
  type        = string
}
