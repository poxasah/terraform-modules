##################
# Vars Environments
#####
variable "project" {
  description = "The name of projetct"
}

variable "environment" {
  description = "The name of environment"
}

variable "region" {
  description = "The region AWS"
}

variable "ssh_key_name" {
  description = "Name of ssh key"
}

variable "internaldns" {
  description = "DNS Internal"
}
##################
# Vars VPC
#####
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "subnet_private_list" {
  description = "Private Subnet configuration list"
  type = list(object({
    name              = string,
    cidr              = string,
    availability_zone = string
  }))
}

variable "subnet_public_list" {
  description = "Public Subnet configuration list"
  type = list(object({
    name              = string,
    cidr              = string,
    availability_zone = string
  }))
}

##################
# Vars Bastion
#####
variable "bastion_ami_name" {
  description = "AMI ID"
}

variable "bastion_ec2_type" {
  description = "EC2 Type"
}

variable "bastion_instances" {
  description = "Number of Instances"
  default     = 0
}

variable "bastion_ebs_size" {
  description = "EBS size"
}