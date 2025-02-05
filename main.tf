# VPC Module
module "vpc" {
  source               = "./module/VPC"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr

}



#Security Group Module
module "securitygroups" {
  source      = "./module/securitygroups"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

#Instances Module
module "servers" {
  source                = "./module/instances"
  instance_type         = var.instance_type
  public_subnet_id      = module.vpc.public_subnet_id
  web_security_group_id = module.securitygroups.security_group_ids[0]
  //key_name = var.key_name
  environment = var.environment
}

#Alb Load Balancer
module "loadbalancer" {
  source         = "./module/loadbalencer"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_id[*]
  alb_sg_id      = module.securitygroups.security_group_ids[2]
  target_id      = module.servers.instance_ids[0]
}

#RDS Module
module "rds" {
  source               = "./module/rds"
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  environment          = var.environment
  rds_sg_id            = module.securitygroups.security_group_ids[3]
  subnet_ids           = module.vpc.private_subnet_id
}


