output "alb_arn" {
  description = "this is the arn of the alb" 
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "Name of the application target gruop " 
  value = aws_lb_target_group.app.name
}

output "listener_arn" {
  description = "ARN of the http listener"
  value = aws_lb_listener.http.arn
}


