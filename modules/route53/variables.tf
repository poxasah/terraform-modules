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
# DNS Internal
#####
variable "vpc_id" {
  description = "VPC ID"
}
variable "internaldns" {
  description = "Internal DNS"
}