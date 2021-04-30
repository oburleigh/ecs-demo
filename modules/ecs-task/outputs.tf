output "ecs_task_family" {
  value = aws_ecs_task_definition.default.family
}

output "ecs_task_revision" {
  value = aws_ecs_task_definition.default.revision
}

output "ecs_task_arn" {
  value = aws_ecs_task_definition.default.arn
}