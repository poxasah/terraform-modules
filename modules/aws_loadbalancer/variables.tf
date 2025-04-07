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

##################
# Vars VPC
#####
variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_public_id" {
  description = "ID Subnets Publics"
}

##################
#Security Groups
#####
variable "alb_security_group" {
  description = "ALb security group"
}

##################
# Vars SSL ALB
#####
variable "grafana_cname_name" {
  description = "Name subdominio"
}

variable "publicdns" {
  description = "Wildcard DNS"
}