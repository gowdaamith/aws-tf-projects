module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = var.vpc_cidr
  project_name    = var.project_name
  environment     = var.environment
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
}


