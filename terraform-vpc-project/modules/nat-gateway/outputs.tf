output "nat_gateway_id" {
  description = "Id of the nat gateway"
  value = aws_nat_gateway.this.id
}

output "elastic_ip" {
  description = "Elastic ip address associated with the nat gateway"
  value = aws_eip.this.public_ip
}


