##################
# Application Load Balancer
#####
resource "aws_lb" "application_lb" {
  name               = "${var.project}-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group]
  subnets            = var.subnet_public_id

  tags = {
    Name        = "${var.project}-alb"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

###################
### Listener ALB 80 - Redirect 443
#######
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_302"

      host  = "#{host}"
      path  = "/#{path}"
      query = "#{query}"
    }
  }
}

####################
### Listener ALB 443
#######
#resource "aws_lb_listener" "https_listener" {
#  load_balancer_arn = aws_lb.application_lb.arn
#  port              = 443
#  protocol          = "HTTPS"
#
#  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#  certificate_arn = var.ssl_certificate_alb_arn
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.tg_application.arn
#  }
#}

##################
# Create Target Group P80
#####
resource "aws_lb_target_group" "tg_application_ec2" {
  name        = "${var.project}-tg-application"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  vpc_id = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 20
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  ip_address_type = "ipv4"

  tags = {
    Name        = "${var.project}-tg-application"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}