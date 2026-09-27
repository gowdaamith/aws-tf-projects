output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Map of private route table IDs"
  value = {
    for key, route_table in aws_route_table.private :
    key => route_table.id
  }
}

output "database_route_table_ids" {
  description = "Map of database route table IDs"
  value = {
    for key, route_table in aws_route_table.database :
    key => route_table.id
  }
}
