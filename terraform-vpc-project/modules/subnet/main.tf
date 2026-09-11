resource "aws_subnet" "this" {
  for_each = var.subnets
  vpc_id =var.vpc_id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
  tags = {
    name = "${var.project_name}_${var.environment}-${var.subnet_tier}-${each.key}"
    tier = var.subnet_tier
  }
}


