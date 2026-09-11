resource "aws_backup_vault" "this" {
  name = "${var.environment}-ec2-backup-vault"
  tags = {
    name = "${var.environment}-ec2-backup-vault"
    environment = var.environment
    managedby = "terraform "
  }

}
data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type = "Services"
      identifiers = ["backup.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "backup" {
  name = "${var.environment}-aws-backup-role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
  tags = {
    name = "${var.environment}-aws-backup-role"
    environment = var.environment
    managedby = "terraform"
  }
}


resource "aws_iam_role_policy_attachment" "backup" {
  role = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

}

resource "aws_backup_plan" "this" {
  name = "${var.environment}-ec2-backup-plan"
  rule {
    rule_name = "${var.environment}-daily-backup"
    target_vault_name = aws_backup_vault.this.name
    schedule = "cron(0 20 * * ? *)"
    lifecycle {
      delete_after = 30
    }
  }
  tags = {
    name = "${var.environment}-ec2-backup-plan"
    environment = var.environment
    managedby = "terraform"
  }
}


resource "aws_backup_selection" "this" {
  name = "${var.environment}-ec2-backup-selection"
  iam_role_arn = aws_iam_role.backup.arn
  plan_id = aws_backup_plan.this.id
  selection_tag {
    type = "STRINGEQUALS"
    key = "Backup" 
    value = "true"
  }
}

