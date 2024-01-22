output "vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}
output "public_subnets_cidr" {
  value = module.subnets.public_subnets_cidr
}
output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}
output "private_subnets_cidr" {
  value = module.subnets.private_subnets_cidr
}
output "private_subnet_id" {
  value = module.subnets.private_subnet_id
}
output "all_security_group_ids" {
  value = module.securitygroups.security_group_ids
}
output "all_instance_ids" {
  value = module.servers.instance_ids
}
output "all_servers_public_ip" {
  value = module.servers.public_ips
}
output "loadbalancers_dns" {
  value = module.loadbalancer.loadbalancers_dns
}
output "rds_instance_arn" {
  value = module.rds.rds_instance_arn
}
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
output "db_subnet_group_subnet_ids" {
  value = module.rds.subnet_ids
}