##################
# VPC
#####
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project}-vpc"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Private Subnet
#####
resource "aws_subnet" "subnet_private" {
  count                   = length(var.subnet_private_list)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_private_list[count.index].cidr
  availability_zone       = var.subnet_private_list[count.index].availability_zone
  map_public_ip_on_launch = false
  depends_on              = [aws_internet_gateway.internet_gateway]

  tags = {
    Name        = "${var.project}-${var.subnet_private_list[count.index].name}"
    Project     = var.project
    Environment = var.environment
  }

}

##################
# Public Subnets
#####
resource "aws_subnet" "subnet_public" {
  count                   = length(var.subnet_public_list)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_list[count.index].cidr
  availability_zone       = var.subnet_public_list[count.index].availability_zone
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.internet_gateway]

  tags = {
    Name        = "${var.project}-${var.subnet_public_list[count.index].name}"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Internet Gateway
#####
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project}-internet-gateway"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Route Table IG - Public
#####
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name        = "${var.project}-route-public"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_subnet" {
  count          = length(aws_subnet.subnet_public)
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}

##################
# Elastic IP for NAT Gateway
#####
resource "aws_eip" "nat_ip" {
  tags = {
    Name        = "${var.project}-nat-ip"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# NAT Gateway
#####
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.subnet_public[0].id

  tags = {
    Name        = "${var.project}-nat-gateway"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Private Route Table
#####
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.project}-private-table"
    Project     = var.project
    Environment = var.environment
  }
}

##################
# Associate private route table on NAT gateway
#####
resource "aws_route_table_association" "route_table_private" {
  count          = length(aws_subnet.subnet_private)
  subnet_id      = aws_subnet.subnet_private[count.index].id
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