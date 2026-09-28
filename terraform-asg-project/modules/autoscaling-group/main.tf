resource "aws_autoscaling_group" "this" {
  name = "${var.name_prefix}-asg"
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  
  vpc_zone_identifier = values(var.private_subnet_ids)
  target_group_arns = [
    var.target_group_arn
  ]
  health_check_type = "ELB"
  health_check_grace_period = 300
  launch_template {
    id = var.launch_template_id
    version = var.launch_template_version
  }
  tag {
    key = "Name"
    value = "${var.name_prefix}-app"
    propagate_at_launch = true
  }
  tag { 
    key = "Project"
    value = var.name_prefix
    propagate_at_launch = true
  }
  tag {
    key = "ManagedBy"
    value = "Terraform"
    propagate_at_launch = true
  }
  
}


