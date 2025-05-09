##################
# Security Group Associate to ALB
#####
resource "aws_security_group" "alb_security_group" {
  name        = "${var.project}-alb-sg"
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
  }
}

##################
# Security Group Internal
#####
resource "aws_security_group" "internal_security_group" {
  name        = "${var.project}-app-sg"
  description = "Defau"
  vpc_id      = var.vpc_id

    ingress {
    description = "Intenal instances in the VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    }

    ingress {
    description     = "HTTP do ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
    }

    egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    Name = "${var.project}-app-sg"
  }
}

##################
# Security Group Bastion
#####
resource "aws_security_group" "bastion_security_group" {
  name        = "${var.project}-bastion-sg"
  description = "Bastion Rules"
  vpc_id      = var.vpc_id
  
    ingress {
    description = "SSH Sabrina"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["179.84.106.33/32"]
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
  }

}
