##################
# EC2 grafana
#####
resource "aws_instance" "grafana" {
  ami           = var.grafana_ami_name
  instance_type = var.grafana_ec2_type
  subnet_id     = var.subnet_private_id
  count         = var.grafana_instances
  key_name      = var.ssh_key_name
  ebs_optimized = true
  root_block_device {
    volume_size = var.grafana_ebs_size
    encrypted   = true
  }

  tags = {
    Name        = "${var.project}-grafana-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    Application = "grafana"
  }

  volume_tags = {
    Name        = "${var.project}-grafana-${count.index + 1}-root"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    Application = "grafana"
  }

  vpc_security_group_ids = [
    var.default_security_group,
  ]
  lifecycle {
    prevent_destroy = false
  }

}

##################
# grafana IP DNS
#####
resource "aws_route53_record" "grafana_a_record" {
  zone_id = var.route53_zone_id
  name    = "grafana-${count.index + 1}.${var.internaldns}."
  type    = "A"
  ttl     = 60
  count   = var.grafana_instances
  records = [element(aws_instance.grafana.*.private_ip, count.index)]
  lifecycle {
    prevent_destroy = false
  }
}

##################
# EC2 Grafana Associate TG ALB
#####
#resource "aws_lb_target_group_attachment" "tg_attachment_grafana" {
#  count            = var.grafana_instances
#  target_group_arn = var.tg_grafana_arn
#  target_id        = aws_instance.grafana[count.index].id
#  port             = 3000
#}
