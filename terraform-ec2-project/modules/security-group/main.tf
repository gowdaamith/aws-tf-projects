resource "aws_security_group" "this" {
  name = "${var.environment}-ec2-sg"
  description = "Security group for ${var.environment} ec2 instance"
  vpc_id = var.vpc_id
  tags =  {
    name = "${var.environment}-ec2-sg"
    environment = var.environment
    managedby = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule"  "ssh" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4 = var.allow_ssh_cidr
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  description = "Allow SSH access"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port= 80
  ip_protocol = "tcp"
  description = "Allow HTTP traffic"
}

resource "aws_vpc_security_group_ingress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow outbound traffic"
}


  
    
