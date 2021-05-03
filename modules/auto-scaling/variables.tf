variable "ecs_cluster_name" {
  type        = string
  description = "Name for ECS cluster"
}

variable "ecs_service_name" {
  default     = "webappservice"
  type        = string
  description = "Name for the service"
}

variable "min_capacity" {
  type = number
  description = "The min capacity of the scalable target."
}

variable "max_capacity" {
  type = number
  description = "The max capacity of the scalable target."
}

variable "mem_target_value" {
  type = number
  description = "The target value for the memory metric"
}

variable "cpu_target_value" {
  type = number
  description = "The target value for the CPU metric"
}
