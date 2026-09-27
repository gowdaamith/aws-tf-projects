resource "aws_eip" "this" {
  for_each = var.public_subnet_ids
  domain = "vpc"
  tags = {
    name = "${each.key}-eip"
  }

}

resource "aws_nat_gateway" "this" {
  for_each = var.public_subnet_ids
  subnet_id = each.value
  allocation_id = aws_eip.this[each.key].id
  tags= {
    name = "${each.key}"
  }
  depends_on = [
    aws_eip.this
  ]
}


