output "public_nacl_id" {
  description = "Id of the public nacl" 
  value = aws_network_acl.public.id
}

output "private_nacl_id" {
  description = "Id of the private nacl"
  value = aws_network_acl.private.id
}

output "database_nacl_id" {
  description = "ID of the database nacl"
  value = aws_network_acl.database.id
}


