output "vpc_id" {
  description = "Id of the vpc"
  value       = module.vpc.id
}

output "vpc_cidr" {
  description = "cidr block of the vpc"
  value       = module.vpc.vpc_cidr
}


output "subnet_ids" {
  description = "all subnet Ids"
  value       = module.subnet.subnet_ids
}


output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet ids "
  value       = module.subnet.private_subnet_ids
}

output "database_subnet_ids" {
  description = "Database subnet ids"
  value       = module.subnet.database_subnet_ids

}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = module.internet_gateway.internet_gateway_id
}


