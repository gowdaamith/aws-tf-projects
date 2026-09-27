module "vpc" {
  source     = "../../modules/vpc"
  name       = "${var.project_name}-${var.environment}-vpc"
  cidr_range = var.cidr_range
}

module "subnet" {
  source  = "../../modules/subnet"
  vpc_id  = module.vpc.id
  subnets = var.subnets
}

module "internet_gateway" {
  source = "../../modules/internet-gateway"
  vpc_id = module.vpc.id
  name   = "${var.project_name}-${var.environment}-igw"
}


