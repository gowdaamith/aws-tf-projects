resource "a:wq:wqws_iam_role" "ec2" {
  name = "${var.environment}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    name = "${var.environment}-ec2-role"
    environment = var.environment
    managedby = "terraform"
  }
  resource "aws_iam_role_policy_attachment" "ssm" {
    role = aws_iam_role.ec2.name
    policy_arn = "arn:aws:iam:aws:policy/AmazonSSMManagedInstanceCore"
  }
  resource 
           
