output "internal_security_group" {
  value = aws_security_group.internal_security_group.id
}

output "alb_security_group" {
  value = aws_security_group.alb_security_group.id
}

output "bastion_security_group" {
  value = aws_security_group.bastion_security_group.id
}

