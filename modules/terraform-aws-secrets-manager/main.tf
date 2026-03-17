resource "aws_secretsmanager_secret" "this" {
  count                   = var.create_secret ? 1 : 0
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key_id == "aws/secretsmanager" ? null : var.kms_key_id
  recovery_window_in_days = var.recovery_window_in_days

  tags = merge(
    {
      Name        = var.name
      PROVISIONER = "Terraform"
    },
    var.used_for_service != null ? { Used_For_Service = var.used_for_service } : {},
    var.tags
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  count     = var.create_secret && var.secret_string != null ? 1 : 0
  secret_id = aws_secretsmanager_secret.this[0].id
  secret_string = (
    can(tostring(var.secret_string))
    ? tostring(var.secret_string)
    : jsonencode(var.secret_string)
  )
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count               = var.create_secret && var.enable_rotation ? 1 : 0
  secret_id           = aws_secretsmanager_secret.this[0].id
  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
}
