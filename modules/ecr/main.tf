locals {
  ecr_image = var.ecr_image
  module_name = "ecr"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_ecr_repository" "name" {
  name                 = var.ecr_image
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.ecr_image}-${local.module_name}-${terraform.workspace}"
  })
}

resource "null_resource" "ecr_image" {
  provisioner "local-exec" {
    command     = "${coalesce(var.push_script, "${path.module}/push.sh")} ${var.build_path} ${aws_ecr_repository.name.repository_url} ${var.tag}"
    interpreter = ["bash", "-c"]
  }
}
