data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "this" {
  for_each = var.instance_configs
  name_prefix = "${var.name_prefix}-${each.key}"
  image_id = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  iam_instance_profile {
    name = var.instance_profile_name
  }
  metadata_options {
    http_endpoint = "enabled" 
    http_tokens = "required" 
    http_put_response_hop_limit = 1
    instance_metadata_tags = "enabled" 
  }
  monitoring { 
    enabled = true
  }
  user_data= base64encode(var.user_data)
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = each.value.volume_size
      volume_type = each.value.volume_type
      encrypted = true
      delete_on_termination = true
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      name = "${var.name_prefix}-${each.key}"
    }
  }
  tag_specifications {
    resource_type = "volume" 
    tags = {
      name = "${var.name_prefix}-${each.key}-volume"
    }
  }
}

 
