output "nat_gateway_public_ip" {
  value = aws_eip.nat_ip.public_ip
}