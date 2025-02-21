output "demo_dns" {
  value = aws_route53_record.demo_a_record.*.name
}
