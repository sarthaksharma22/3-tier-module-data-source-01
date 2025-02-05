vpc_cidr = "10.0.0.0/16"

public_subnets_cidr = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets_cidr = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

environment = "dev"

instance_type = "t2.micro"
//key_name = "my-key-pair"

allocated_storage    = 20
storage_type         = "gp2"
engine               = "mysql"
engine_version       = "8.0"
instance_class       = "db.t3.micro"
username             = "admin"
password             = "securepassword"
parameter_group_name = "default.mysql8.0"
access_key           = "your-aws-access-key"
secret_key           = "your-aws-secret-key"
region               = "us-east-1" # Change as per your AWS region
