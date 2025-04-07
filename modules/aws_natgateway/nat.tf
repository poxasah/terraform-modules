##################
# Elastic IP for NAT Gateway
#####
resource "aws_eip" "nat_ip" {
  tags = {
    Name        = "${var.project}-nat-ip"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

##################
# NAT Gateway
#####
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = var.subnet_public_id

  tags = {
    Name        = "${var.project}-nat-gateway"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

##################
# Private Route Table
#####
resource "aws_route_table" "route_table_private" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.project}-private-route-table"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
  lifecycle {
    ignore_changes = [route]
    prevent_destroy = false
  }
}

##################
# Associate private route table on NAT gateway
#####
resource "aws_route_table_association" "route_table_private" {
  count          = length(var.subnet_private_id)
  subnet_id      = var.subnet_private_id[count.index]
  route_table_id = aws_route_table.route_table_private.id
}


##################
# Add Route to NAT Gateway in Private Route Table
#####
resource "aws_route" "route_private" {
  route_table_id         = aws_route_table.route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}