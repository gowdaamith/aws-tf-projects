resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = var.public_subnet_id
  tags = {
    name = var.name
  }
  depends_on = [
    aws_eip.this
  ]
}



resource "aws_eip" "this" {
  domain = "vpc" 
  tags = {
    name = "${var.name}-eip"
  }
}


