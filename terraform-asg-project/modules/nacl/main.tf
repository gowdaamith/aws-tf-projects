resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id
}

resource "aws_network_acl_association" "public" {
  for_each=var.public_subnet_ids
  subnet_id = each.value
  network_acl_id = aws_network_acl.public.id
}

resource "aws_network_acl_rule" "public_ingress_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number= 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  
  from_port= 80
  to_port= 80
}



resource "aws_network_acl_rule" "public_ingress_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number = 101
  egress = false
  protocol = "tcp" 
  rule = "allow"
  cidr_block = "0.0.0.0/0"
  
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "public_ingress_ssh" {
  network_acl_id = aws_network_acl.public.id
  rule_number = 102
  egress= false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  
  from_port = 22
  to_port = 22
}


resource "aws_network_acl_rule" "public_ingress_ephemeral" {
  rule_number = 103
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  
  from_port = 1024
  to_port= 65535
}

resource "aws_network_acl_rule" "public_egress_all" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 100
  egress      = true
  protocol    = "-1"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"
}


############################################################################


resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id
  
}

resource "aws_network_acl_association" "private" {
  for_each = var.private_subnet_id
  subnet_id = each.value
  network_acl_id = aws_network_acl.private.id
}

resource "aws_network_acl_rule" "private_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = var.vpc_cidr
  from_port= 0
  to_port = 65535
}

resource "aws_network_acl_rule" "private_ingress_ephemeral" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 101
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}

resource "aws_network_acl_rule" "private_egress_internet" {
  rule_number = 102
  egress=true
  protocol="tcp"
  rule_action= "allow"
  cidr_block= "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "private_egress_ephemeral" {
  network_acl_id = aws_network_acl.private.id

  rule_number = 120
  egress      = true
  protocol    = "tcp"

  rule_action = "allow"

  cidr_block = "0.0.0.0/0"

  from_port = 1024
  to_port   = 65535
}



