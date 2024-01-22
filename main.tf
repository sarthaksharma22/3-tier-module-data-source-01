# VPC Module
module "vpc" {
  source       = "./Project/VPC"
  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
}

#Subnets Module
module "subnets" {
  source = "./Project/subnets"
  vpc_id = module.vpc.vpc_id
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  environment = var.environment
}

#Security Group Module
module "securitygroups" {
  source = "./Project/securitygroups"
  vpc_id = module.vpc.vpc_id
  environment = var.environment
}

#Instances Module
module "servers" {
  source = "./Project/instances"
  instance_type = var.instance_type
  public_subnet_id = module.subnets.public_subnet_id[0]
  web_security_group_id = module.securitygroups.security_group_ids[0]
  key_name = var.key_name
  environment = var.environment
}

#Alb Load Balancer
module "loadbalancer" {
  source = "./Project/loadbalencer"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.subnets.public_subnet_id[*]
  alb_sg_id = module.securitygroups.security_group_ids[2]
  target_id = module.servers.instance_ids[0]
}

#RDS Module
module "rds" {
  source = "./Project/rds"
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  username = var.username
  password = var.password
  parameter_group_name = var.parameter_group_name
  environment = var.environment
  rds_sg_id = module.securitygroups.security_group_ids[3]
  subnet_ids = module.subnets.private_subnet_id
}


