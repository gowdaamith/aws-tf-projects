resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id
  tags = {
    name = "public-nacl"
    type = "public" 
  }

}
resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id
  tags = {
    name = "private-nacl"
    type = "private"
  }
}

resource "aws_network_acl" "database" {
  vpc_id = var.vpc_id
  tags = {
    name = "database-nacl"
    type = "database"
  }
}


resource "aws_network_acl_rule" "public_ingress_http" {
  network_acl_id= aws_network_acl.public.id
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port=80
  to_port=80
}



resource "aws_network_acl_rule" "public_ingress_https" {
  network_acl_id= aws_network_acl.public.id
  rule_number = 110
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port=443
  to_port=443
}

resource "aws_network_acl_rule" "public_egress_http" {
  network_acl_id= aws_network_acl.public.id
  rule_number = 100
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port=80
  to_port=80
}



resource "aws_network_acl_rule" "public_egress_https" {
  network_acl_id= aws_network_acl.public.id
  rule_number = 110
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port=443
  to_port=443
}


resource "aws_network_acl_rule" "public_egress_ephemeral" {
  network_acl_id= aws_network_acl.public.id
  rule_number = 120
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port=1024
  to_port=65535
}


resource "aws_network_acl_rule" "private_ingress_http" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 100
  egress      = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "10.0.0.0/16"
  from_port = 80
  to_port   = 80
}

resource "aws_network_acl_rule" "private_ingress_https" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 110
  egress      = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "10.0.0.0/16"
  from_port = 80
  to_port   = 80
}

resource "aws_network_acl_rule" "private_engress_http" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 120
  egress      = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 443
  to_port   = 443
}

resource "aws_network_acl_rule" "private_egress_ephemeral" {
  network_acl_id = aws_network_acl.private.id
  rule_number = 110
  egress      = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port   = 65535
}

resource "aws_network_acl_rule" "database_ingress_postgresql" {
  network_acl_id = aws_network_acl.database.id
  rule_number = 100
  egress      = false 
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "10.0.0.0/16"
  from_port = 5432
  to_port   = 5432
}

resource "aws_network_acl_rule" "database_egress_ephemeral" {
  network_acl_id = aws_network_acl.database.id
  rule_number = 100
  egress      = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "10.0.0.0/16"
  from_port = 1024
  to_port   = 65535
}

resource "aws_network_acl_association" "public" {
  for_each = var.public_subnet_ids
  network_acl_id = aws_network_acl.public.id
  subnet_id = each.value
}

resource "aws_network_acl_association" "private" {
  for_each = var.private_subnet_ids
  network_acl_id = aws_network_acl.private.id
  subnet_id = each.value
}

resource "aws_network_acl_association" "database" {
  for_each = var.database_subnet_ids
  network_acl_id = aws_network_acl.database.id
  subnet_id = each.value
}
