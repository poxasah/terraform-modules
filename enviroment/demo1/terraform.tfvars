##################
# Global
#####
project            = "tf-demo1"
environment        = "demo1"
owner              = "sabrina-demo1"
region             = "us-west-2"
vpc_cidr           = "172.16.0.0/16"
internaldns        = "sabrina-demo1.us-west-2"
publicdns          = "sabrinadbs.com"
ssh_key_name       = "sabrina-demo"

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
# DNS Public
#####
grafana_cname_name           = "grafana"

##################
# Bastion
#####
bastion_ami_name  = "ami-075686beab831bb7f" //Ubuntu 24.04 , AMI AWS
bastion_ec2_type  = "t3a.small"
bastion_instances = "1"
bastion_ebs_size  = 8

##################
# Grafana
#####
grafana_ami_name  = "ami-075686beab831bb7f" //Ubuntu 24.04 , AMI AWS
grafana_ec2_type  = "t3a.small"
grafana_instances = "1"
grafana_ebs_size  = 50