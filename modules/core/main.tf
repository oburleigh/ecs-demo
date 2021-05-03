locals {
  module_name = "core"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

data "aws_availability_zones" "main" {
  state = "available"
}

data "aws_region" "current" {}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-${local.module_name}-${terraform.workspace}"
  })
}

resource "aws_subnet" "public" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.default.id

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-public-subnet-${local.module_name}-${terraform.workspace}"
    SubnetType = "Public"
  })
}

resource "aws_subnet" "private" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = "10.0.${count.index + 100}.0/24"
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  vpc_id                  = aws_vpc.default.id

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-private-subnet-${local.module_name}-${terraform.workspace}"
    SubnetType = "Private"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-${local.module_name}-${terraform.workspace}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = merge(local.default_tags, {
    Name       = "${var.name}-public-route-table"
    SubnetType = "public"
  })
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id         = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = 2
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  tags = merge(local.default_tags, {
    Name       = "${var.name}-private-route-table"
    SubnetType = "private"
  })
}

resource "aws_route_table_association" "private" {
  count          = 2
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.default.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]
}

resource "aws_vpc_endpoint" "dkr" {
  vpc_id              = aws_vpc.default.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [var.vpce_security_group_id]
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_vpc_endpoint" "api" {
  vpc_id              = aws_vpc.default.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [var.vpce_security_group_id]
  subnet_ids = aws_subnet.private[*].id
}
resource "aws_lb" "elb" {
  name               = "webapptest"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = aws_subnet.public.*.id
}

resource "aws_lb_target_group" "ecs" {
  name     = "ecs"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.default.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs.id
  }
}
