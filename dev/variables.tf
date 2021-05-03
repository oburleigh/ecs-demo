variable "region" {
  default     = "eu-west-2"
  type        = string
  description = "The region you want to deploy the infrastructure in"
}

#====================================Core Variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Public Subnet"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Private Subnet"
}

variable "map_public_ip_on_launch" {
  default     = true
  type        = bool
  description = "Subnet to be mapped to Public IP"
}

variable "map_public_ip_on_launch_private" {
  default     = false
  type        = bool
  description = "Subnet to be mapped to Public IP"
}

variable "tags" {
  type        = map(any)
  description = "A map of tags to assign to the resource"
}

variable "core_name" {
  type        = string
  description = "Unique name for the VPC"
}

#====================================ECR Variables
variable "ecr_build_path" {
  type        = string
  description = "Path to Dockerfile"
}

variable "ecr_image" {
  type        = string
  description = "name for image"
}

variable "ecr_image_tag" {
  default     = "latest"
  type        = string
  description = "tag for image"
}

#==================================ECS Variables
variable "ecs_cluster_name" {
  type        = string
  description = "Name for ECS cluster"
}

variable "capacity_providers" {
  description = "List of Capacity Provider"
}

#==================================ECS Service Variables
variable "ecs_service_name" {
  default     = "webappservice"
  type        = string
  description = "Name for the service"
}

variable "ecs_service_launch_type" {
  default     = "FARGATE"
  type        = string
  description = "Launch Type to be FARGATE or EC2"
}

variable "ecs_service_desired_count" {
  default     = 1
  type        = number
  description = "how many instances to attrain to"
}

variable "load_balancer_container_port" {
  default     = 80
  type        = number
  description = "how many instances to attrain to"
}

variable "load_balancer_container_name" {
  default     = "webapp"
  type        = string
  description = "how many instances to attrain to"
}

variable "ecs_service_assign_pub_ip" {
  default     = true
  type        = bool
  description = "Assign Public IP to the Service"
}

#==================================ECS Task Variables
variable "ecs_task_family" {
  type        = string
  description = "Name of Task Family"
}

variable "ecs_task_network_mode" {
  default     = "awsvpc"
  type        = string
  description = "Network mode for task"
}

variable "ecs_task_req_compat" {
  default     = "awsvpc"
  description = "List choices of Fargate and EC2"
}

variable "ecs_task_cpu" {
  default     = 256
  type        = number
  description = "CPU allocation for Task"
}

variable "ecs_task_mem" {
  default     = 512
  type        = number
  description = "Memory allocation for Task"
}

variable "ecs_task_container_mem" {
  default     = 512
  type        = number
  description = "Container Memory allocation for Task"
}

variable "ecs_task_container_cpu" {
  default     = 256
  type        = number
  description = "Container CPU allocation for Task"
}

variable "ecs_task_name" {
  type        = string
  description = "name of task"
}

#=========================================Auto Scaling Variables

variable "aws_appautoscaling_target_min_capacity" {
  type        = number
  description = "The min capacity of the scalable target."
}

variable "aws_appautoscaling_target_max_capacity" {
  type        = number
  description = "The max capacity of the scalable target."
}

variable "target_policy_mem_target_value" {
  type        = number
  description = "The target value for the memory metric"
}

variable "target_policy_cpu_target_value" {
  type        = number
  description = "The target value for the CPU metric"
}
