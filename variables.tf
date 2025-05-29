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
  # TODO こちらを取得したドメインに書き換える。
  default     = "oolab.tech"
}

variable "subdomain" {
  description = "Subdomain for the API"
  type        = string
  # TODO こちらを取得したドメインに書き換える。
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
  # TODO こちらを書き換えてリソースを作成する。
  default     = "todo_app_prod_db"
}

variable "db_username" {
  description = "Database username"
  type        = string
  # TODO こちらを書き換えてリソースを作成する。
  default     = "todo_app_admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  # TODO こちらを書き換えてリソースを作成する。
  default   = "password01"
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
  # TODO 取得したドメインに置き換える。
  default     = "https://oolab.tech,https://www.oolab.tech"
}