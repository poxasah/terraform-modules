##################
# Global
#####
project      = "tf-dev"
environment  = "dev"
region       = "us-west-2"
vpc_cidr     = "172.16.0.0/16"
internaldns  = "sabrina-dev.us-west-2"
ssh_key_name = "sabrina-dev"

##################
# Subnets Multi-AZ
#####
subnet_private_list = [
  {
    name              = "private-subnet-2a",
    cidr              = "172.16.128.0/22"
    availability_zone = "us-west-2a"
  },
  {
    name              = "private-subnet-2b",
    cidr              = "172.16.132.0/22"
    availability_zone = "us-west-2b"
  },
  {
    name              = "private-subnet-2c",
    cidr              = "172.16.136.0/22"
    availability_zone = "us-west-2c"
  }
]

subnet_public_list = [
  {
    name              = "public-subnet-2a",
    cidr              = "172.16.0.0/24"
    availability_zone = "us-west-2a"
  },
  {
    name              = "public-subnet-2b",
    cidr              = "172.16.1.0/24"
    availability_zone = "us-west-2b"
  },
  {
    name              = "public-subnet-2c",
    cidr              = "172.16.2.0/24"
    availability_zone = "us-west-2c"
  }
]

##################
# Bastion
#####
bastion_ami_name  = "ami-0e2c8caa4b6378d8c" //Ubuntu 24.04 , AMI AWS
bastion_ec2_type  = "t3a.small"
bastion_instances = "1"
bastion_ebs_size  = 8