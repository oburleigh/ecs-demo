provider "aws" {
  region = var.region
}

# IAM - Task execution role, needed to pull ECR images etc.
resource "aws_iam_role" "execution" {
  name               = "example-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "task_execution" {
  name   = "example-task-execution"
  role   = aws_iam_role.execution.id
  policy = data.aws_iam_policy_document.task_execution_permissions.json
}

# IAM - Basic Role.
resource "aws_iam_role" "task" {
  name               = "example-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

module "core" {
  name                     = var.core_name
  source                   = "../modules/core"
  map_public_ip_on_launch  = var.map_public_ip_on_launch
  tags                     = var.tags
  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
}

module "ecr" {
  source     = "../modules/ecr"
  build_path = var.ecr_build_path
  ecr_image  = var.ecr_image
  image_tag  = var.ecr_image_tag
  tags       = var.tags
}

module "ecs" {
  source             = "../modules/ecs"
  name               = "webapp"
  tags               = var.tags
  capacity_providers = var.capacity_providers
}


# Security group for Service
resource "aws_security_group" "backend" {
  name        = "SG_backend"
  description = "Backend security group"
  vpc_id      = module.core.vpc_id
}

# Allow traffic from the the internet to service
resource "aws_security_group_rule" "backend-ingress" {
  description = "allow traffic from load balancer"
  type        = "ingress"

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend.id
}

# Allow outbound traffic from the service
resource "aws_security_group_rule" "backend-egress" {
  description = "allow all outbound traffic"
  type        = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.backend.id
}

module "ecs-service" {
  source           = "../modules/ecs-service"
  name             = var.ecs_service_name
  cluster          = module.ecs.ecs_cluster_id
  desired_count    = var.ecs_service_desired_count
  task_definition  = module.ecs-task.ecs_task_arn
  launch_type      = var.ecs_service_launch_type
  subnets          = [module.core.public_subnet_id]
  security_groups  = [aws_security_group.backend.id]
  assign_public_ip = var.ecs_service_assign_pub_ip
  tags             = var.tags
}

module "ecs-task" {
  source                   = "../modules/ecs-task"
  family                   = var.ecs_task_family
  requires_compatibilities = var.ecs_task_req_compat
  network_mode             = var.ecs_task_network_mode
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_mem
  execution_role_arn       = aws_iam_role.execution.arn
  name                     = var.ecs_task_name
  image                    = "${module.ecr.repository_url}:${var.ecr_image_tag}"
  container_cpu            = var.ecs_task_container_cpu
  container_memory         = var.ecs_task_container_mem
}
