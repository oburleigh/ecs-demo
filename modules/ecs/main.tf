locals {
  module_name = "ecs"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_ecs_cluster" "default" {
  name = "webapp"

  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(local.default_tags, {
    Name = "${local.module_name}-${terraform.workspace}"
  })
}