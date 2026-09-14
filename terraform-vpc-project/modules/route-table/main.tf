resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = {
    name = var.name
  }
}

resource "aws_route_table_association" "this" {
  for_each       = var.subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.this.id
}

resource "aws_route" "internet" { 
  count = var.create_internet_route ? 1:0
  
  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.internet_gateway_id
  
}

resource "aws_route" "nat" {
  count = var.create_nat_route ? 1:0
  
  route_table_id = aws_route_table.this.id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id = var.nat_gateway_id

}




