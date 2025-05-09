##################
# Vars Environments
#####
variable "project" {
  description = "The name of projetct"
}

variable "environment" {
  description = "The name of environment"
}

variable "internaldns" {
  description = "DNS Internal"
}

variable "ssh_key_name" {
  description = "Name of ssh key"
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

##################
# Bastion
#####
variable "bastion_ami_name" {
  description = "AMI Name"
}
variable "bastion_ec2_type" {
  description = "EC2 type"
}
variable "bastion_instances" {
  description = "Number of instances"
  default     = "1"
}

variable "bastion_ebs_size" {
  description = "EBS size"
}


##################
#Security Groups
#####
variable "internal_security_group" {
  description = "Default security group"
}

variable "bastion_security_group" {
  description = "Bastion security group"
}