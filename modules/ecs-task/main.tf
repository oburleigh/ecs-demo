locals {
  module_name = "ecs-task"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_ecs_task_definition" "default" {
  family = var.family
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name = var.name
      image = var.image
      cpu = var.container_cpu
      memory = var.container_memory
    }
  ])
  
  tags = merge(local.default_tags, {
    Name = "${var.family}-${local.module_name}-${terraform.workspace}"
  })
}

