output "arn" {
  description = "this is the arn of the asg vpc created"
  value       = aws_vpc.this.arn
}

output "id" {
  description = "this is the id of the asg vpc created"
  value       = aws_vpc.this.id
}


output "vpc_cidr" {
  description = "cidr block of the vpc"
  value       = aws_vpc.this.cidr_block
}




