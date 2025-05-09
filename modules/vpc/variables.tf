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

##################
# Vars VPC
#####
variable "vpc_cidr" {
  description = "CIDR block"
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