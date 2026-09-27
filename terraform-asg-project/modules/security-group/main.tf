resource "aws_security_group" "alb" {
  name = "alb-sg" 
  description = "Security group for  application load balancer"
  vpc_id =  var.vpc_id
  tags = {
    name = "alb-sg"
    type = "alb"
   }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  description = "Allow http from the internet" 
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https"{
  security_group_id = aws_security_group.alb.id
  description = "Allow https from the internet"
  ip_protocol= "tcp"
  from_port=443
  to_port=443
  cidr_ipv4="0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id = aws_security_group.alb.id
  description = "Allow alb traffic to application servers"
  ip_protocol= "tcp"
  from_port=80
  to_port = 80
  cidr_ipv4 = var.vpc_cidr
}



resource "aws_security_group" "app" {
  name= "app-sg"
  description = "Security group for the ec2 instance of the autoscaling group"
  vpc_id = var.vpc_id
  tags = {
    name = "app-sg"
    type = "application"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id = aws_security_group.app.id
  description = "Allow http from the internet"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
  referenced_security_group_id = aws_security_group.alb.id
}


resource "aws_vpc_security_group_egress_rule" "app_https" {
  security_group_id = aws_security_group.app.id
  description= "Allow https outbount"
  ip_protocol = "tcp"
  from_port =443
  to_port=443
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "Security group for database resources"
  vpc_id      = var.vpc_id

  tags = {
    Name = "database-sg"
    Type = "database"
  }
}

resource "aws_vpc_security_group_ingress_rule" "database_postgresql" {
  security_group_id = aws_security_group.database.id
  description = "Allow postgresql from applications erver" 
  ip_protocol = "tcp"
  from_port = 5432
  to_port=5432
  referenced_security_group_id = aws_security_group.app.id
}

resource "aws_vpc_security_group_egress_rule" "database_vpc" {
  security_group_id = aws_security_group.database.id
  description = "Allow database traffic inside vpc"
  ip_protocol= "-1"
  cidr_ipv4 = var.vpc_cidr
}


