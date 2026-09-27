output "nat_gateway_ids" {
  description = "this is the ids of the nat gateway" 
  value = {
    for key,nat_gateway in aws_nat_gateway.this:
    key => nat_gateway.id
  }
}

output "nat_gateway_public_ips" {
  description ="map of public subnet names to nat gateway public ips"
  value = {
    for  key,eip in aws_eip.this: 
    key => eip.public_ip
  }
}
