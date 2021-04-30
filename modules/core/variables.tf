variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Private Subnet"
}

variable "map_public_ip_on_launch" {
  default = true
  type        = bool
  description = "Subnet to be mapped to Public IP"
}

variable "tags" {
  type = map
  description = "A map of tags to assign to the resource"
}

variable "name" {
  type        = string
  description = "Unique name for the VPC"
}
