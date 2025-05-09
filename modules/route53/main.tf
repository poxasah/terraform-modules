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
  }
  vpc {
    vpc_id     = var.vpc_id
    vpc_region = var.region
  }
  lifecycle {
    ignore_changes = [vpc]
  }
}