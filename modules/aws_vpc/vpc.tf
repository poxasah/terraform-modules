##################
# VPC
#####
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = false

  tags = {
    Name        = "${var.project}-vpc"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
 lifecycle {
    prevent_destroy = false
  }
}

##################
# Private Subnet 3 AZ
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
    Owner       = var.owner
  }
  lifecycle {
    prevent_destroy = false
  }
}

##################
# Public Subnets 3 AZ
#####
resource "aws_subnet" "subnet_public" {
  count                   = length(var.subnet_public_list)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_list[count.index].cidr
  availability_zone       = var.subnet_public_list[count.index].availability_zone
  map_public_ip_on_launch = false
  depends_on              = [aws_internet_gateway.internet_gateway]

  tags = {
    Name        = "${var.project}-${var.subnet_public_list[count.index].name}"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
  lifecycle {
    prevent_destroy = false
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
    Owner       = var.owner
  }
  lifecycle {
    prevent_destroy = false
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
    Name        = "${var.project}-route-table-public"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
  lifecycle {
    ignore_changes = [route]
     prevent_destroy = false
  }

}

# Now associate the route table with the public subnet - giving all public subnet instances access to the internet.
resource "aws_route_table_association" "public_subnet" {
  count          = length(aws_subnet.subnet_public)
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}