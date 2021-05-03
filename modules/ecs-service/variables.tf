variable "name" {
  type        = string
  description = "Unique name for the ECS Service"
}
variable "launch_type" {
  type        = string
  description = "Type to Run Service, either FARGATE or EC2"
}

variable "security_groups" {
  type = list(string)
  description = "Security Group Associated with Service"
}

variable "subnets" {
  description = "List of subnets to attach to the service"
}

variable "cluster" {
  type        = string
  description = "ARN of an ECS cluster"
}

variable "task_definition" {
  type        = string
  description = "ARN of an Task Definition to Run in Service"
}

variable "desired_count" {
  type        = number
  description = "Number of services required"
}

variable "tags" {
  type = map
  description = "A map of tags to assign to the resource"
}

variable "assign_public_ip" {
  type = bool
  description = "Assign a public IP to this service"
}

variable "target_group_arn" {
  type = string
  description = "update"
}

variable "container_name" {
  type = string
  description = "update"
}

variable "container_port" {
  type = number
  description = "update"
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
