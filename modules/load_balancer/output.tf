output "alb_dns_name" {
  value = aws_lb.application_lb.dns_name
}

output "tg_application" {
  value = aws_lb_target_group.tg_application.arn
}
