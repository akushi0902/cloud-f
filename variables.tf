variable "region" {
  type        = string
  description = "AWS region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single NAT gateway"
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Allowed SSH CIDR"
}

variable "subnet_az_a_name" {
  type        = string
  description = "Subnet AZ-A name"
}

variable "subnet_az_b_name" {
  type        = string
  description = "Subnet AZ-B name"
}

variable "iam_role_name" {
  type        = string
  description = "IAM role name"
}

variable "instance_profile_name" {
  type        = string
  description = "IAM instance profile name"
}

variable "ec2_name" {
  type        = string
  description = "EC2 instance name"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
  default     = null
}
