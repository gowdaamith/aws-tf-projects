data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["099720109477"]
}

module "ec2" {
  source               = "../../modules/ec2"
  ami_id               = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_id
  security_group_id    = [module.security_groups.security_group_id]
  instance_name        = "${var.environment}-web-server"
  environment          = var.environment
  iam_instance_profile = module.iam.instance_profile_name
  data_volume_size     = var.data_volume_size
  availability_zone    = var.availability_zone
  user_data = templatefile(
    "${path.root}/../../scripts/user-data.sh",
    {
      environment = var.environment
    }
  )
}


module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  environment        = var.environment
}

module "security_groups" {
  source         = "../../modules/security-group"
  vpc_id         = module.vpc.vpc_id
  environment    = var.environment
  allow_ssh_cidr = var.allowed_ssh_cidr
}

module "iam" {
  source      = "../../modules/iam"
  environment = var.environment
}

module "backup" {
  source      = "../../modules/backup"
  environment = var.environment
}

