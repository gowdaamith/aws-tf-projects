variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "target_cpu_utilization" {
  description = "Target average CPU utilization percentage"
  type        = number
}
