resource "aws_instance" "this" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_id
  iam_instance_profile  = var.iam_instance_profile
  user_data= var.user_data
  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted = true
    delete_on_termination = true
  }
 
  tags = {
    Name = var.instance_name
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}


