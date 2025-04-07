output "default_security_group" {
  value = aws_security_group.vpc_default_sg.id
}

output "bastion_security_group" {
  value = aws_security_group.bastion_sg.id
}

output "alb_security_group" {
  value = aws_security_group.alb_sec_group.id
}