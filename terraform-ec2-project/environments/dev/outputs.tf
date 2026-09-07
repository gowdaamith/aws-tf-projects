output "instance_id" {
  description = "Ec2 instance ID"
  value       = module.ec2.instance_id
}
output "private_ip" {
  description = "Private IP of the Ec2 instance"
  value       = module.ec2.private_ip
}

output "public_ip" {
  description = "Public IP of the Ec2 instance"
  value       = module.ec2.public_ip
}

output "ubuntu_ami_id" {
  description = "ubuntu ami selected for this environment"
  value       = data.aws_ami.ubuntu.id
}


