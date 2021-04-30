output "registry_id" {
  value       = aws_ecr_repository.name.registry_id
  description = "Registry ID"
}

output "repository_name" {
  value       = aws_ecr_repository.name.name
  description = "Name of first repository created"
}

output "repository_url" {
  value       = aws_ecr_repository.name.repository_url
  description = "URL of first repository created"
}

output "repository_arn" {
  value       = aws_ecr_repository.name.arn
  description = "ARN of first repository created"
}
