output "instance_id" {
  description = "ID of the ec2 instance"
  value =aws_instance.this.id
}

output "private_ip" {
  description = "Private IP address of the instance" 
  value = aws_instance.this.private_ip
}

output "public_ip" {
  description = "public ip address fo the Ec2 instance "
  value = aws_instance.this.public_ip
}

