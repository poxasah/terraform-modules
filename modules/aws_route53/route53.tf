##################
# DNS Internal Route53
#####
resource "aws_route53_zone" "internal" {
  name    = "${var.internaldns}."
  comment = "Internal DNS"

  tags = {
    Name        = "${var.project}-dns"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  vpc {
    vpc_id     = var.route53_vpc_id
    vpc_region = var.region
  }
  lifecycle {
    ignore_changes = [vpc]
  }

}

##################
# DNS Public Route53
#####
resource "aws_route53_zone" "public" {
  name    = "${var.publicdns}."
  comment = "Public DNS"

  tags = {
    Name        = "${var.project}-dns"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}