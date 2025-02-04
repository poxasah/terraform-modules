output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_public_id" {
  value = aws_subnet.subnet_public[*].id
}

output "private_subnet_id" {
  value = aws_subnet.subnet_private[*].id
}

output "subnet_private_az" {
  value = var.subnet_private_list[*].availability_zone
}

output "public_subnet_az" {
  value = var.subnet_public_list[*].availability_zone
}

output "nat_gateway_public_ip" {
  value = aws_eip.nat_ip.public_ip
}