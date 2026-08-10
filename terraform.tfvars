region = "ap-south-1"

vpc_name                 = "ec2-dev"
vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["ap-south-1a"]
public_subnet_cidrs      = ["10.0.1.0/24"]
private_subnet_cidrs     = []
enable_dns_support       = true
enable_dns_hostnames     = true
map_public_ip_on_launch  = true
enable_nat_gateway       = false
single_nat_gateway       = false

subnet_name                     = "public-ec2-dev"
subnet_cidr_block               = "10.0.1.0/24"
subnet_availability_zone        = "ap-south-1a"
subnet_map_public_ip_on_launch  = true
assign_ipv6_address_on_creation = false
ipv6_cidr_block                 = null
additional_routes               = []
default_route_target_type       = "gateway_id"
default_route_target_id         = null
create_route_table              = true

security_group_name        = "ec2-public-dev"
security_group_description = "Allow all inbound and outbound traffic"
ingress_rules = [
  {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
egress_rules = [
  {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
revoke_rules_on_delete   = false
default_egress_allow_all = true

iam_role_name = "role-ec2-dev"
iam_role_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ec2.amazonaws.com"]
  }
]
iam_role_managed_policy_arns    = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
iam_role_description            = ""
iam_role_path                   = "/"
iam_role_max_session_duration   = 3600
iam_role_force_detach_policies  = false
iam_role_inline_policies        = {}

iam_instance_profile_name = "profile-ec2-dev"
iam_instance_profile_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ec2.amazonaws.com"]
  }
]
iam_instance_profile_managed_policy_arns    = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
iam_instance_profile_description            = ""
iam_instance_profile_path                   = "/"
iam_instance_profile_max_session_duration   = 3600
iam_instance_profile_force_detach_policies  = false
iam_instance_profile_inline_policies        = {}

ec2_name                             = "ec2-dev"
ami_id                               = "ami-0c02fb55956c7d316"
instance_type                        = "t3.micro"
associate_public_ip                  = true
key_name                             = "ec2-dev"
ebs_delete_on_termination            = true
ebs_encrypted                        = true
ebs_volume_type                      = "gp3"
ebs_volume_size                      = 30
monitoring                           = false
metadata_http_tokens                 = "required"
metadata_http_put_response_hop_limit = 1
ec2_tags = {
  environment = "dev"
  service     = "ec2"
}

default_tags = {
  team = "platform"
  service = "ec2"
  environment = "dev"
}
