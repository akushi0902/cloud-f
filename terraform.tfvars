region               = "ap-south-1"

vpc_name             = "dev"
cidr_block           = "11.0.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["11.0.1.0/24", "11.0.2.0/24"]
private_subnet_cidrs = ["11.0.10.0/24", "11.0.11.0/24"]
enable_dns_support   = true
enable_dns_hostnames = true
map_public_ip_on_launch = true
enable_nat_gateway   = false
single_nat_gateway   = false

security_group_name  = "ec2-dev"
allowed_ssh_cidr     = "0.0.0.0/0"

subnet_az_a_name     = "public-az-a-dev"
subnet_az_b_name     = "public-az-b-dev"

iam_role_name         = "role-ec2-ssm-dev"
instance_profile_name = "profile-ec2-dev"

ec2_name      = "ec2-dev"
instance_type = "t3.micro"
key_name      = null

default_tags = {
  team = "platform"
  service = "ec2-infra"
  environment = "dev"
}
