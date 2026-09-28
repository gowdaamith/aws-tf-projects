resource "aws_lb" "this" {
  name = "${var.prefix_name}-alb"
  load_balancer_type = var.load_balancer_type
  internal= false
  security_groups = [
    var.security_group_ids
  ]
  subnets = values(var.public_subnet_ids)
  enable_deletion_protection = false
  tags  = {
    name = "${var.prefix_name}-alb"
    type = "application_load_balancer"
  }
}

resource "aws_lb_target_group" "app" {
  name = "${var.prefix_name}-atg"
  port = 80
  target_type = "instance"
  protocol = "HTTP" 
  vpc_id = var.vpc_id
  stickiness {
    enabled = true
    type  = "lb_cookie"
    cookie_duration = 86400
  }
  
  health_check  {
    enabled = true
    protocol = "HTTP"
    path = "/"
    port = "traffic-port"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout= 5
    interval = 30
    matcher = "200"
  }
  tags = {
     Name = "${var.prefix_name}-tg"
    Type = "application-target-group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP" 
  default_action  {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}


