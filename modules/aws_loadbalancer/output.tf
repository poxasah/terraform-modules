output "alb_dns_name" {
  value = aws_lb.application_lb.dns_name
}

output "tg_grafana_arn" {
  value = aws_lb_target_group.tg_grafana.arn
}