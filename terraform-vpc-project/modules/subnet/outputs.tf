output "subnet_id" {
  description = "the subnet id's are"
  value = {
    for name, subnet in aws_subnet.this :
    name => subnet.id
  }
}



