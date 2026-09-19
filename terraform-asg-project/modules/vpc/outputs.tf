output "vpc_id" {
  description = "this is the id of the vpc created "
  value = aws_vpc.this.id
}


output "internet_gateway_id" {
  description = "this is the id  of the internet gateway "
  value = aws_internet_gateway.this.id
  
}

output "public_subnet_id" {
  description = "map of public subnet id's" 
  value =  {
    for key,subnet in aws_subnet.public: key=> subnet.id
  }
}

output "private_subnet_id" {
  description = "map of the private subnet id's"
  value = {
    for key,subnet in aws_subnet.private: key=> subnet.id
  }
}


output "nat_gateway_eip" {
  description = "Elastic ip associated with the nat gateway"
  value = try(aws_eip.nat[0].public_ip,null)
}

output "nat_gateway_id" {
  description = "This is the nat gateway id" 
  value = try(aws_nat_gateway.this[0].id,null)
}



