locals {
  private_nat_gateway_ids = {
    private_app_az1 = module.nat_gateway.nat_gateway_ids["public_az1"]
    private_app_az2 = module.nat_gateway.nat_gateway_ids["public_az2"]
    private_app_az3 = module.nat_gateway.nat_gateway_ids["public_az3"]
  }
}



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


module "route_table" {
  source              = "../../modules/route-table"
  vpc_id              = module.vpc.id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  public_subnet_ids   = module.subnet.public_subnet_ids
  private_subnet_ids  = module.subnet.private_subnet_ids
  database_subnet_ids = module.subnet.database_subnet_ids
  nat_gateway_ids     = local.private_nat_gateway_ids
}

module "nat_gateway" {
  source            = "../../modules/nat-gateway"
  vpc_id            = module.vpc.id
  public_subnet_ids = module.subnet.public_subnet_ids
}


module "nacl" {
  source              = "../../modules/nacl"
  vpc_id              = module.vpc.id
  public_subnet_ids   = module.subnet.public_subnet_ids
  private_subnet_ids  = module.subnet.private_subnet_ids
  database_subnet_ids = module.subnet.database_subnet_ids
}

module "security_group" {
  source   = "../../modules/security-group"
  vpc_id   = module.vpc.id
  vpc_cidr = module.vpc.vpc_cidr
}

module "iam" {
  source = "../../modules/iam"

  name_prefix = "${var.project_name}-${var.environment}"
}
