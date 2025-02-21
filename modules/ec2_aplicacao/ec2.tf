##################
# EC2 demo
#####
resource "aws_instance" "demo" {
  ami           = var.demo_ami_name
  instance_type = var.demo_ec2_type
  subnet_id     = var.subnet_private_id
  count         = var.demo_instances
  key_name      = var.ssh_key_name
  ebs_optimized = true
  root_block_device {
    volume_size = var.demo_ebs_size
    encrypted   = true
  }

  tags = {
    Name        = "${var.project}-demo-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  volume_tags = {
    Name        = "${var.project}-demo-${count.index + 1}-root"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  vpc_security_group_ids = [
    var.default_security_group,
  ]
  lifecycle {
    prevent_destroy = true
  }

}

##################
# demo IP DNS
#####
resource "aws_route53_record" "demo_a_record" {
  zone_id = var.route53_zone_id
  name    = "demo-${count.index + 1}.${var.internaldns}."
  type    = "A"
  ttl     = 60
  count   = var.demo_instances
  records = [element(aws_instance.demo.*.private_ip, count.index)]
  lifecycle {
    prevent_destroy = true
  }

}

##################
# EC2 demo Associate TG ALB
#####
resource "aws_lb_target_group_attachment" "tg_attachment_demo" {
  count            = var.demo_instances
  target_group_arn = var.tg_application
  target_id        = aws_instance.demo[count.index].id
  port             = 80
}