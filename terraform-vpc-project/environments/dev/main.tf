module "vpc" {
  source       = "../../modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment

}

module "igw" {
  source = "../../modules/internet-gateway"
  name   = var.igw_name
  vpc_id = module.vpc.vpc_id

}

module "public_subnets" {
  source = "../../modules/subnet"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  subnet_tier  = "public"
  subnets      = var.public_subnets
}

module "private_app_subnet" {
  source = "../../modules/subnet"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  subnet_tier  = "private-app"
  subnets       = var.private_app_subnets
}

module "database_subnets" {
  source       = "../../modules/subnet"
  project_name = var.project_name
  environment = var.environment
  vpc_id       = module.vpc.vpc_id
  subnet_tier  = "database"
  subnets       = var.database_subnets
}





