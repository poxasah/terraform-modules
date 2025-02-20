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


module "aws_application_lb" {
  source                       = "../../modules/load_balancer"
  region                       = var.region
  project                      = var.project
  environment                  = var.environment
  owner                        = var.owner
  vpc_id                       = module.vpc.vpc_id
  subnet_public_id             = module.vpc.subnet_public_id[*]
  ssl_certificate_alb_arn      = var.ssl_certificate_alb_arn
  alb_security_group           = module.security_group.alb_security_group

}
module "route53" {
  source         = "../../modules/route53"
  region         = var.region
  project        = var.project
  environment    = var.environment
  owner          = var.owner
  internaldns    = var.internaldns
  route53_vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source      = "../../modules/security_group"
  region      = var.region
  project     = var.project
  environment = var.environment
  owner       = var.owner
  vpc_id      = module.vpc.vpc_id
}

module "aws_s3" {
  source      = "../../modules/buckets_s3"
  project     = var.project
  environment = var.environment
  owner       = var.owner
}

module "bastion" {
  source                 = "../../modules/bastion"
  region                 = var.region
  project                = var.project
  environment            = var.environment
  owner                  = var.owner
  internaldns            = var.internaldns
  ssh_key_name           = var.ssh_key_name
  vpc_id                 = module.vpc.vpc_id
  subnet_public_id       = module.vpc.subnet_public_id[0]
  default_security_group = module.security_group.default_security_group
  bastion_security_group = module.security_group.bastion_security_group
  route53_zone_id        = module.route53.route53_zone_id
  bastion_ami_name       = var.bastion_ami_name
  bastion_ec2_type       = var.bastion_ec2_type
  bastion_ebs_size       = var.bastion_ebs_size
}

