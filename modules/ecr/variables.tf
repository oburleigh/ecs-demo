variable "tags" {
  type = map
  description = "A map of tags to assign to the resource"
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
}

variable "scan_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  default     = true
}

variable "ecr_image" {
  type        = string
  description = "List of Docker local image names, used as repository names for AWS ECR "
}

variable "tag" {
  description = "Tag to use for deployed Docker image"
  type        = string
  default     = "latest"
}

variable "hash_script" {
  description = "Path to script to generate hash of source contents"
  type        = string
  default     = ""
}

variable "push_script" {
  description = "Path to script to build and push Docker image"
  type        = string
  default     = ""
}

variable "build_path" {
  description = "Path to Dockerfile"
  type        = string
  default     = ""
}

variable "image_tag" {
  description = ""
  type = string
}