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