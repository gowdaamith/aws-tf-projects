resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = {
    name = var.name
  }
}

resource "aws_route_table_subnet_association" "this" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.this.id
}


