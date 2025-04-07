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

##################
# DNS Internal
#####
variable "route53_vpc_id" {
  description = "Route 53 VPC ID"
}
variable "internaldns" {
  description = "Internal DNS"
}

variable "publicdns" {
  description = "Public DNS"
}