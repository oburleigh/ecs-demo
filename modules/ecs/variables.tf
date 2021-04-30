variable "name" {
  type        = string
  description = "Unique name for the ECS Cluster"
}

variable "tags" {
  type = map
  description = "A map of tags to assign to the resource"
}

variable "capacity_providers" {
  description = "List of Cap Providers"
}
