resource "aws_iam_role" "this" {
  name = "${var.environment}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Pricipal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name        = "${var.environment}-ec2-role"
    Environment = var.environment
    Managedby   = "Terraform"
  }

}



resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.environment}-ec2-profile"
  role = aws_iam_role.this.name
  tags = {
    name        = "${var.environment}-ec2-profile"
    environment = var.environment
    managedby   = "terraform"
  }
}

