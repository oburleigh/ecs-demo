locals {
  module_name = "core"
  default_tags = {
    Owner = "Terraform"
    Env = terraform.workspace
  }
}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr_block

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-${local.module_name}-${terraform.workspace}"
  })
}

resource "aws_subnet" "public" {
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.default.id

  tags = merge(local.default_tags, var.tags, {
    Name    = "${var.name}-subnet-${local.module_name}-${terraform.workspace}"
    SubnetType = "Public"
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
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}
