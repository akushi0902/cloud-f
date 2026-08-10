data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "app.terraform.io/TF01/vpc/aws"
  version = "~> 1.0.0"

  name                    = var.vpc_name
  cidr_block              = var.cidr_block
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  tags                    = {}
}

module "security_group" {
  source  = "app.terraform.io/TF01/security-group/aws"
  version = "~> 1.0.0"

  name        = var.security_group_name
  vpc_id      = module.vpc.vpc_id
  description = "Managed by Terraform"

  ingress_rules = [
    {
      description      = ""
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [var.allowed_ssh_cidr]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    },
    {
      description      = ""
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    },
    {
      description      = ""
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    }
  ]

  egress_rules = [
    {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    }
  ]

  revoke_rules_on_delete   = false
  default_egress_allow_all = true
  tags                     = {}
}

module "subnet_az_a" {
  source  = "app.terraform.io/TF01/subnet/aws"
  version = "~> 1.0.0"

  name                      = var.subnet_az_a_name
  vpc_id                    = module.vpc.vpc_id
  cidr_block                = var.public_subnet_cidrs[0]
  availability_zone         = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch   = true
  create_route_table        = true
  default_route_target_type = "gateway_id"
  default_route_target_id   = null
  additional_routes         = []
  tags                      = {}
}

module "subnet_az_b" {
  source  = "app.terraform.io/TF01/subnet/aws"
  version = "~> 1.0.0"

  name                      = var.subnet_az_b_name
  vpc_id                    = module.vpc.vpc_id
  cidr_block                = var.public_subnet_cidrs[1]
  availability_zone         = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch   = true
  create_route_table        = true
  default_route_target_type = "gateway_id"
  default_route_target_id   = null
  additional_routes         = []
  tags                      = {}
}

module "iam_role" {
  source  = "app.terraform.io/TF01/iam-role/aws"
  version = "~> 1.0.0"

  name = var.iam_role_name

  assume_role_principals = [
    {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  ]

  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  description           = ""
  max_session_duration  = 3600
  force_detach_policies = false
  inline_policies       = {}
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
}

resource "aws_iam_instance_profile" "ec2" {
  name = var.instance_profile_name
  role = module.iam_role.role_name
}

module "ec2" {
  source  = "app.terraform.io/TF01/ec2/aws"
  version = "~> 1.0.0"

  name                                 = var.ec2_name
  ami_id                               = data.aws_ami.amazon_linux_2023.id
  instance_type                        = var.instance_type
  subnet_id                            = module.subnet_az_a.subnet_id
  vpc_security_group_ids               = [module.security_group.security_group_id]
  iam_instance_profile                 = aws_iam_instance_profile.ec2.name
  key_name                             = var.key_name
  associate_public_ip                  = true
  monitoring                           = true
  ebs_volume_type                      = "gp3"
  ebs_volume_size                      = 30
  ebs_encrypted                        = true
  ebs_delete_on_termination            = true
  metadata_http_tokens                 = "required"
  metadata_http_put_response_hop_limit = 1
  user_data                            = null
  user_data_base64                     = null
  tags                                 = {}
}
