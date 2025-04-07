###################
## AWS Certificate SSL ALB Wildcard
######
resource "aws_acm_certificate" "ssl_certificate_alb" {
  domain_name = "*.${var.publicdns}"

  validation_method = "DNS"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "${var.project}-certificate"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

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

  lifecycle {
    prevent_destroy = false
  }

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

###################
## Listener ALB 443
######
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = aws_acm_certificate.ssl_certificate_alb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_grafana.arn
  }

  lifecycle {
    prevent_destroy = false
  }
}

###################
## Rules Listener ALB 443 - Grafana
######
resource "aws_lb_listener_rule" "grafana_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 1

  condition {
    host_header {
      values = ["${var.grafana_cname_name}.${replace(var.publicdns, "*.", "")}"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_grafana.arn
  }
}

##################
# Create Target Group EC2 Grafana 3000
#####
resource "aws_lb_target_group" "tg_grafana" {
  name        = "${var.project}-tg-grafana"
  port        = 3000
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
    Name        = "${var.project}-tg-grafana"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}