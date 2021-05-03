locals {
  module_name = "ecs-service"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_ecs_service" "default" {
  name = var.name
  cluster = var.cluster
  task_definition = var.task_definition
  desired_count = var.desired_count
  launch_type = var.launch_type
 
  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = var.load_balancer_container_name
    container_port = var.load_balancer_container_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = merge(local.default_tags, {
    Name = "${var.name}-${local.module_name}-${terraform.workspace}"
  })
}
