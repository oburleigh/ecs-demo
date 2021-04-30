output "vpc_id" {
  value       = aws_vpc.default.id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.default.cidr_block
  description = "The CIDR block of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}
