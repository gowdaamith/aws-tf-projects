resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
     name = "${var.project_name}-${var.environment}-vpc"
   }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each  = var.public_subnets
   
  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true
  
  tags = {
    name = "${var.project_name}-${var.environment}-${each.key}-public_subnet"  
  }

}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch =false
  
  tags = {
    name = "${var.project_name}-${var.environment}-${each.key}-private_subnet"
  }
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1:0
  domain= "vpc"
  tags = {
    name = "${var.project_name}-${var.environment}-${each.key}-eip"
  }
}



resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public["public_a"].id

  depends_on = [
    aws_internet_gateway.this
  ]
} 


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {
    name =  "${var.project_name}-${var.environment}-public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    name =  "${var.project_name}-${var.environment}-private-route-table"
  }
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id
  destination_cidr = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this[0].id
}



resource "aws_route_table_association" "this" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
  
}
