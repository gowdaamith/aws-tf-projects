resource "aws_flow_log" "this" {
  vpc_id = var.vpc_id
  traffic_type = var.traffic_type
  log_destination_type = "s3"
  log_destination = var.log_destination
  tags ={
    Name = var.name
  }
}


