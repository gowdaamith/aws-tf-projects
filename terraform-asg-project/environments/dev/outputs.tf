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

output "nat_gateway_ids" {
  description = "NAT gateway ids"
  value       = module.nat_gateway.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  description = "NAT gateway public ip addresses"
  value       = module.nat_gateway.nat_gateway_public_ips
}


output "public_nacl_id" {
  description = "public_nacl_id"
  value       = module.nacl.public_nacl_id
}

output "private_nacl_id" {
  description = "private nacl Id "
  value       = module.nacl.private_nacl_id
}

output "database_nacl_id" {
  description = "private nacl id"
  value       = module.nacl.database_nacl_id
}


output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.security_group.alb_security_group_id
}

output "app_security_group_id" {
  description = "Application security group ID"
  value       = module.security_group.app_security_group_id
}

output "database_security_group_id" {
  description = "Database security group ID"
  value       = module.security_group.database_security_group_id
}

output "iam_role_name" {
  description = "EC2 IAM role name"
  value       = module.iam.iam_role_name
}

output "iam_role_arn" {
  description = "EC2 IAM role ARN"
  value       = module.iam.iam_role_arn
}

output "instance_profile_name" {
  description = "EC2 instance profile name"
  value       = module.iam.instance_profile_name
}
