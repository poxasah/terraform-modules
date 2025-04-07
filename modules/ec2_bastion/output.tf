output "bastion_public_ip" {
  value = aws_eip.ip_bastion.*.public_ip
}

output "bastion_dns" {
  value = aws_route53_record.bastion_a_record.*.name
}
