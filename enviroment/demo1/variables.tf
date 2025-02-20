##################
# Vars Environments
#####
variable "project" {
  description = "The name of projetct"
}

variable "environment" {
  description = "The name of environment"
}

variable "owner" {
  description = "Name Owner"
}

variable "region" {
  description = "The region to deploy the cluster in, e.g: sa-east-1."
}

variable "internaldns" {
  description = "Internal DNS NAME"
}

variable "ssh_key_name" {
  description = "Name of ssh key"
}

##################
# Vars VPC
#####
variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
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

variable "ssl_certificate_alb_arn" {
  description = "ARN Certificate AWS"
}