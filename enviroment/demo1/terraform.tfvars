##################
# Global
#####
project                 = "terraform-sabrina"
environment             = "demo1"
owner                   = "sabrinademo1@gmail.com"
region                  = "sa-east-1"
vpc_cidr                = "192.168.0.0/16"
internaldns             = "tf-sabrina-demo1.sa-east-1"
ssh_key_name            = "sabrina-demo1"
ssl_certificate_alb_arn = "arn:aws:acm:"

##################
# Subnets Multi-AZ
#####
subnet_private_list = [
  {
    name              = "private-subnet-1a",
    cidr              = "192.168.128.0/22"
    availability_zone = "sa-east-1a"
  },
  {
    name              = "private-subnet-1b"
    cidr              = "192.168.132.0/22"
    availability_zone = "sa-east-1b"
  },
  {
    name              = "private-subnet-1c"
    cidr              = "192.168.136.0/22"
    availability_zone = "sa-east-1c"
  }
]

subnet_public_list = [
  {
    name              = "public-subnet-1a",
    cidr              = "192.168.0.0/24"
    availability_zone = "sa-east-1a"
  },
  {
    name              = "public-subnet-1b",
    cidr              = "192.168.1.0/24"
    availability_zone = "sa-east-1b"
  },
  {
    name              = "public-subnet-1c"
    cidr              = "192.168.2.0/24"
    availability_zone = "sa-east-1c"
  }
]


##################
# Bastion
#####
bastion_ami_name  = "ami-04d88e4b4e0a5db46" //AMI Ubuntu 24 AWS
bastion_ec2_type  = "t3a.small"
bastion_instances = "1"
bastion_ebs_size  = 8

##################
# Demo
#####
demo_ami_name ="ami-04d88e4b4e0a5db46" //AMI Ubuntu 24 AWS
demo_ec2_type  = "t3a.small"
demo_instances = "1"
demo_ebs_size  = 20