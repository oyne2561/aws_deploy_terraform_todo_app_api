# terraform/parameter_store.tf

# データベース接続情報
resource "aws_ssm_parameter" "database_url" {
  name  = "/${var.app_name}/DATABASE_URL"
  type  = "SecureString"
  value = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.main.endpoint}/${var.db_name}"

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_ssm_parameter" "rails_env" {
  name  = "/${var.app_name}/RAILS_ENV"
  type  = "String"
  value = "production"

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_ssm_parameter" "rails_master_key" {
  name  = "/${var.app_name}/RAILS_MASTER_KEY"
  type  = "SecureString"
  value = var.rails_master_key

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_ssm_parameter" "secret_key_base" {
  name  = "/${var.app_name}/SECRET_KEY_BASE"
  type  = "SecureString"
  value = var.secret_key_base

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

# その他の環境変数（必要に応じて追加）
resource "aws_ssm_parameter" "cors_origins" {
  name  = "/${var.app_name}/CORS_ORIGINS"
  type  = "String"
  value = var.cors_origins

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}