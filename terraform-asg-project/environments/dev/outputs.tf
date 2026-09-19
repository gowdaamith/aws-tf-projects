output "vpc_id" {
  description = "this is the id of the vpc"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet ID's"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  description = "Private subnet ID's"
  value       = module.vpc.private_subnet_id
}


