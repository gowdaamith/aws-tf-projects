output "flow_log_id" {
  description = "ID of the vpc flow log"
  value = aws_flow_logs.this.id
}


