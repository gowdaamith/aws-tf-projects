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
  subnets      = var.private_app_subnets
}

module "database_subnets" {
  source       = "../../modules/subnet"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  subnet_tier  = "database"
  subnets      = var.database_subnets
}

module "nat_gateway_a" {
  source           = "../../modules/nat-gateway"
  name             = "${var.project_name}-${var.environment}-nat-a"
  public_subnet_id = module.public_subnets.subnet_id["public-a"]
}

module "nat_gateway_b" {
  source           = "../../modules/nat-gateway"
  name             = "${var.project_name}-${var.environment}-nat-b"
  public_subnet_id = module.public_subnets.subnet_id["public-b"]
}

module "nat_gateway_c" {
  source           = "../../modules/nat-gateway"
  name             = "${var.project_name}-${var.environment}-nat-c"
  public_subnet_id = module.public_subnets.subnet_id["public-c"]
}


module "public_route_table" {
  source                = "../../modules/route-table"
  vpc_id                = module.vpc.vpc_id
  name                  = "${var.project_name}-${var.environment}-public-rt"
  subnet_ids            = module.public_subnets.subnet_id
  internet_gateway_id   = module.igw.internet_gateway_id
  create_internet_route = true

}

module "private_route_table_a" {
  source           = "../../modules/route-table"
  vpc_id           = module.vpc.vpc_id
  name             = "${var.project_name}-${var.environment}-private-a-rt"
  subnet_ids       = { a = module.private_app_subnet.subnet_id["private-app-a"] }
  nat_gateway_id   = module.nat_gateway_a.nat_gateway_id
  create_nat_route = true

}

module "private_route_table_b" {
  source           = "../../modules/route-table"
  vpc_id           = module.vpc.vpc_id
  name             = "${var.project_name}-${var.environment}-private-b-rt"
  subnet_ids       = { b = module.private_app_subnet.subnet_id["private-app-b"] }
  nat_gateway_id   = module.nat_gateway_b.nat_gateway_id
  create_nat_route = true
}

module "private_route_table_c" {
  source           = "../../modules/route-table"
  vpc_id           = module.vpc.vpc_id
  name             = "${var.project_name}-${var.environment}-private-c-rt"
  subnet_ids       = { c = module.private_app_subnet.subnet_id["private-app-c"] }
  nat_gateway_id   = module.nat_gateway_c.nat_gateway_id
  create_nat_route = true
}

module "database_route_table_a" {
  source = "../../modules/route-table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-${var.environment}-database-a-rt"
  subnet_ids = { a = module.database_subnets.subnet_id["database-a"]
  }
}

module "database_route_table_b" {
  source = "../../modules/route-table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-${var.environment}-database-b-rt"
  subnet_ids = { b = module.database_subnets.subnet_id["database-b"]
  }
}

module "database_route_table_c" {
  source = "../../modules/route-table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-${var.environment}-database-c-rt"
  subnet_ids = { c = module.database_subnets.subnet_id["database-c"]

  }
}
