output "vpc_id" {
  value       = module.dev_vpc.vpc_id
  description = "VPC ID for dev environment"
}

output "public_subnet_ids" {
  value       = module.dev_vpc.public_subnet_ids
  description = "Public Subnets for dev"
}

output "private_subnet_ids" {
  value       = module.dev_vpc.private_subnet_ids
  description = "Private Subnets for dev"
}

output "nat_gateway_id" {
  value       = module.dev_vpc.nat_gateway_id
  description = "NAT Gateway for dev"
}
