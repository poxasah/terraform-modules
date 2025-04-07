##################
# Security Group VPC Default
#####
resource "aws_security_group" "vpc_default_sg" {
  name        = "${var.project}-vpc-default-sg"
  description = "Default SG that allows all EC2 in the VPC."
  vpc_id      = var.vpc_id

  ingress {
    description = "Internal ingress"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }
  
  ingress {
    description     = "Allow ALB traffic on port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sec_group.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-vpc-default-sg"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

##################
# Security Group Associate to ALB
#####
resource "aws_security_group" "alb_sec_group" {
  name        = "${var.project}-application-lb-sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-alb-sg"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

##################
# Security Group Bastion
#####
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "Bastion Rules"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-bastion-sg"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  lifecycle {
    ignore_changes = [
      ingress, egress
    ]
  }
}