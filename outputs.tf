output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  # 「aws_subnet.public[*].id」 - aws_subnet.publicのすべてのインスタンスのid属性を取得する
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  # 「aws_subnet.private[*].id」 - aws_subnet.privateのすべてのインスタンスのid属性を取得する
  value = aws_subnet.private[*].id
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "ALB zone ID"
  value       = aws_lb.main.zone_id
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "api_url" {
  description = "API URL"
  value       = "https://${var.subdomain}"
}