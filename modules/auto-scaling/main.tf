locals {
  module_name = "auto_scaling"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_appautoscaling_target" "default" {
  max_capacity = var.max_capacity
  min_capacity = var.min_capacity
  resource_id = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "default_mem" {
  name               = "Default Memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.default.resource_id
  scalable_dimension = aws_appautoscaling_target.default.scalable_dimension
  service_namespace  = aws_appautoscaling_target.default.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.mem_target_value
  }
}

resource "aws_appautoscaling_policy" "default_cpu" {
  name = "Default CPU"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.default.resource_id
  scalable_dimension = aws_appautoscaling_target.default.scalable_dimension
  service_namespace = aws_appautoscaling_target.default.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.cpu_target_value
  }
}
