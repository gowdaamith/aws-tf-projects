output "subnet_ids" {
  description = " map the subnet name with the subnet ids " 
  value  = { for key,subnet in aws_subnet.this : key => subnet.id }
}

output "public_subnet_ids" {
  description = "ID's of public subnet "
  value = {
    for key,subnet in aws_subnet.this: 
    key => subnet.id
    if subnet.tags["type"] == "public" 
  }
}

output "private_subnet_ids" {
  description = "ID's of the private subnet" 
  value = {
    for key , subnet in aws_subnet.this:
    key => subnet.id
    if subnet.tags["type"] == "private" 
  }
}

output "database_subnet_ids" {
  description = "ID's of the database subnet" 
  value = {
    for key,subnet in aws_subnet.this : 
    key => subnet.id
    if subnet.tags["type"] == "database" 
  }
}


