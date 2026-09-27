resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  
  tags = {
    name = "public-route-table"
    type = "public"
  }
}

resource "aws_route" "public_internet" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id  = var.internet_gateway_id
}



resource "aws_route_table" "private" {
  for_each = var.private_subnet_ids
  vpc_id = var.vpc_id
  tags = {
    name = "${each.key}-route-table"
    type = "private"
  }
}

resource "aws_route" "private_nat" {
  for_each = var.nat_gateway_ids
  route_table_id = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = each.value
}


resource "aws_route_table" "database" {
  for_each = var.database_subnet_ids
  vpc_id = var.vpc_id
  tags = {
    name ="${each.key}-route-table"
    type = "database"
  }
}

resource "aws_route_table_association" "public" {
  for_each=var.public_subnet_ids
  subnet_id = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_ids
  subnet_id = each.value
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table_association" "database"  {
  for_each = var.database_subnet_ids
  subnet_id = each.value
  route_table_id = aws_route_table.database[each.key].id
}

