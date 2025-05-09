provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source              = "../../modules/vpc"
  region              = var.region
  project             = var.project
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  subnet_private_list = var.subnet_private_list
  subnet_public_list  = var.subnet_public_list
}

module "route53" {
  source      = "../../modules/route53"
  region      = var.region
  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  internaldns = var.internaldns
}

module "security_groups" {
  source      = "../../modules/security_groups"
  region      = var.region
  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

module "s3" {
  source      = "../../modules/s3"
  region      = var.region
  project     = var.project
  environment = var.environment
}

module "bastion" {
  source                  = "../../modules/bastion"
  project                 = var.project
  environment             = var.environment
  ssh_key_name            = var.ssh_key_name
  internaldns             = var.internaldns
  vpc_id                  = module.vpc.vpc_id
  internal_security_group = module.security_groups.internal_security_group
  subnet_public_id        = module.vpc.subnet_public_id[0]
  bastion_ami_name        = var.bastion_ami_name
  bastion_ec2_type        = var.bastion_ec2_type
  bastion_ebs_size        = var.bastion_ebs_size
  bastion_instances       = var.bastion_instances
  bastion_security_group  = module.security_groups.bastion_security_group
}