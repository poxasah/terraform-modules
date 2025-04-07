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
  description = "The region to deploy the cluster in, e.g: us-east-1."
}

variable "internaldns" {
  description = "Internal DNS"
}

variable "ssh_key_name" {
  description = "Name of ssh key"
}

##################
# Vars VPC
#####
variable "subnet_private_id" {
  description = "ID Subnet Private"
}

variable "route53_zone_id" {
  description = "VPC ID"
}

##################
# SG Default VPC
#####
variable "default_security_group" {
  description = "Default security group"
}

##################
# grafana
#####
variable "grafana_ami_name" {
  description = "AMI Name"
}

variable "grafana_ec2_type" {
  description = "EC2 type"
}

variable "grafana_instances" {
  description = "Number of instances"
  default     = "1"
}

variable "grafana_ebs_size" {
  description = "EBS size"
}

#variable "tg_grafana_arn" {
#  description = "ARB Target Group ALB grafana"
#}