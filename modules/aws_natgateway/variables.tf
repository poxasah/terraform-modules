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
  description = "ID Subnet Public"
}

variable "subnet_private_id" {
  description = "ID Subnet Private"
}