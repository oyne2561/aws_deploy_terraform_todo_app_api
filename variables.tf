variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "todo-app-api"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "oolab.tech"
}

variable "subdomain" {
  description = "Subdomain for the API"
  type        = string
  default     = "prod-api.oolab.tech"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "todo_app_prod"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  # TODO こちらを書き換えてリソースを作成する。
  default   = "postgres"
  sensitive = true
}

variable "rails_master_key" {
  description = "Rails master key"
  type        = string
  # TODO Railsで調べ、書き換えて、リソースを作成する
  default   = "rails_master_key"
  sensitive = true
}

variable "secret_key_base" {
  description = "Rails secret key base"
  type        = string
  # TODO Railsで調べ、書き換えて、リソースを作成する
  default   = "secret_key_base"
  sensitive = true
}

variable "cors_origins" {
  description = "CORS origins"
  type        = string
  default     = "https://oolab.tech,https://www.oolab.tech"
}