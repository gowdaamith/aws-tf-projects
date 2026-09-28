resource "aws_autoscaling_policy" "target_tracking" {
  name = "${var.autoscaling_group_name}-target-tracking"

  autoscaling_group_name = var.autoscaling_group_name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_cpu_utilization

    disable_scale_in = false
  }
}
