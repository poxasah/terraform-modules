output "grafana_dns" {
  value = aws_route53_record.grafana_a_record.*.name
}
