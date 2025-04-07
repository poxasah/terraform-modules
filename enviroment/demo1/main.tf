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

module "aws_vpc" {
  source              = "../../modules/aws_vpc"
  region              = var.region
  project             = var.project
  environment         = var.environment
  owner               = var.owner
  vpc_cidr            = var.vpc_cidr
  subnet_private_list = var.subnet_private_list
  subnet_public_list  = var.subnet_public_list
}

module "aws_nat_gateway" {
  source = "../../modules/aws_natgateway"
  project             = var.project
  environment         = var.environment
  owner               = var.owner
  vpc_id              = module.aws_vpc.vpc_id
  subnet_public_id    = module.aws_vpc.subnet_public_id[0]
  subnet_private_id   = module.aws_vpc.private_subnet_id[*]
}

module "aws_route53" {
  source         = "../../modules/aws_route53"
  region         = var.region
  project        = var.project
  environment    = var.environment
  owner          = var.owner
  internaldns    = var.internaldns
  publicdns      = var.publicdns
  route53_vpc_id = module.aws_vpc.vpc_id
}

module "aws_s3" {
  source      = "../../modules/aws_s3"
  project     = var.project
  environment = var.environment
  owner       = var.owner
}

module "aws_security_group" {
  source      = "../../modules/aws_security_group"
  project     = var.project
  environment = var.environment
  owner       = var.owner
  vpc_id      = module.aws_vpc.vpc_id
}

#module "aws_application_lb" {
#  source                       = "../../modules/aws_loadbalancer"
#  project                      = var.project
#  owner                        = var.owner
#  environment                  = var.environment
#  vpc_id                       = module.aws_vpc.vpc_id
#  alb_security_group           = module.aws_security_group.alb_security_group
#  subnet_public_id             = module.aws_vpc.subnet_public_id[*]
#  publicdns                    = var.publicdns
#  grafana_cname_name           = var.grafana_cname_name
#}

module "ec2_bastion" {
  source                 = "../../modules/ec2_bastion"
  region                 = var.region
  project                = var.project
  environment            = var.environment
  owner                  = var.owner
  internaldns            = var.internaldns
  ssh_key_name           = var.ssh_key_name
  vpc_id                 = module.aws_vpc.vpc_id
  subnet_public_id       = module.aws_vpc.subnet_public_id[0]
  default_security_group = module.aws_security_group.default_security_group
  bastion_security_group = module.aws_security_group.bastion_security_group
  route53_zone_id        = module.aws_route53.route53_zone_id
  bastion_ami_name       = var.bastion_ami_name
  bastion_ec2_type       = var.bastion_ec2_type
  bastion_ebs_size       = var.bastion_ebs_size
  bastion_instances      = var.bastion_instances
}

module "ec2_grafana" {
  source                 = "../../modules/ec2_grafana"
  region                 = var.region
  project                = var.project
  environment            = var.environment
  owner                  = var.owner
  internaldns            = var.internaldns
  ssh_key_name           = var.ssh_key_name
  default_security_group = module.aws_security_group.default_security_group
  subnet_private_id      = module.aws_vpc.private_subnet_id[0]
  route53_zone_id        = module.aws_route53.route53_zone_id
  grafana_ami_name       = var.grafana_ami_name
  grafana_ec2_type       = var.grafana_ec2_type
  grafana_ebs_size       = var.grafana_ebs_size
  grafana_instances      = var.grafana_instances
  #tg_grafana_arn         = module.aws_application_lb.tg_grafana_arn
}

