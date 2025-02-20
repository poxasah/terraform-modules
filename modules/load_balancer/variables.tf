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

##################
#Security Groups
#####
variable "alb_security_group" {
  description = "ALb security group"
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
# Vars SSL ALB
#####
variable "ssl_certificate_alb_arn" {
  description = "ARN SSL ALB"
}