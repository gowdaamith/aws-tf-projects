output "public_nacl_id" {
  description = "Public Network ACL ID"
  value       = aws_network_acl.public.id
}

output "private_nacl_id" {
  description = "Private Network ACL ID"
  value       = aws_network_acl.private.id
}
