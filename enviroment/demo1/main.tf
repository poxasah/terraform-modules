provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "../../modules/vpc"
  region              = var.region
  project             = var.project
  environment         = var.environment
  owner               = var.owner
  vpc_cidr            = var.vpc_cidr
  subnet_private_list = var.subnet_private_list
  subnet_public_list  = var.subnet_public_list
}

module "route53" {
  source              = "../../modules/route53"
  region              = var.region
  project             = var.project
  environment         = var.environment
  owner               = var.owner
  internaldns         = var.internaldns
  route53_vpc_id      = module.vpc.vpc_id
}

