##################
# EC2 Bastion
#####
resource "aws_instance" "ec2_bastion" {
  ami                         = var.bastion_ami_name
  instance_type               = var.bastion_ec2_type
  subnet_id                   = var.subnet_public_id
  count                       = var.bastion_instances
  associate_public_ip_address = true

  vpc_security_group_ids = [var.bastion_security_group, var.internal_security_group]

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      key_name
    ]
  }

  root_block_device {
    volume_size = var.bastion_ebs_size
    encrypted   = true
  }

  key_name = var.ssh_key_name

  tags = {
    Name        = "${var.project}-bastion-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }

  volume_tags = {
    Name        = "${var.project}-bastion-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Public IP Bastion
#####
resource "aws_eip" "bastion_ip" {
  instance   = element(aws_instance.ec2_bastion.*.id, count.index)
  domain     = "vpc"
  depends_on = [aws_instance.ec2_bastion]
  count      = var.bastion_instances

  tags = {
    Name        = "${var.project}-bastion-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Bastion IP DNS
#####
resource "aws_route53_record" "bastion_a_record" {
  zone_id = var.vpc_id
  name    = "bastion-${count.index + 1}.${var.internaldns}."
  type    = "A"
  ttl     = 60
  count   = var.bastion_instances
  records = [element(aws_instance.ec2_bastion.*.private_ip, count.index)]
}
