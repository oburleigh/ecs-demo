variable "family" {
  type = string
  description = "unique name for the family of ECS task"
}

variable "name" {
  type = string
  description = "Name of ECS Task"
}

variable "memory" {
  type = number
  description = "memory allocated to ECS task"
}

variable "cpu" {
  type = number
  description = "cpu allocated to ECS task"
}

variable "container_memory" {
  type = number
  description = "memory allocated to ECS task"
}

variable "container_cpu" {
  type = number
  description = "cpu allocated to ECS task"
}

variable "network_mode" {
  type = string
  description = "Network mode allocated to ECS task"

}
variable "execution_role_arn" {
  type = string
  description = "Role associated with execution task on container"
}

variable "requires_compatibilities" {
  type = list(string)
}

variable "image" {
  type = string
  description = "image to be used from repository for task"
}

# variable "task_role_arn" {
#   type = string
#   description = "Allows Amazon ECS container task to make calls to other AWS services"
# }
