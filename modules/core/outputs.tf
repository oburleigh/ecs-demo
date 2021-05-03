output "vpc_id" {
  value       = aws_vpc.default.id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.default.cidr_block
  description = "The CIDR block of the VPC"
}

# output "public_subnet_id" {
#   value = aws_subnet.public.id
# }

# output "private_subnet_id" {
#   value = aws_subnet.private.id
# }

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}
output "target_group_arn_id" {
  value = aws_lb_target_group.ecs.arn
}

output "s3_prefix_list_id" {
  value = aws_vpc_endpoint.s3.prefix_list_id
}
