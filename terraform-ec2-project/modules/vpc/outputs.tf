output "vpc_id" {
  description = "ID of the vpc" 
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value = aws_subnet.public.id
}


