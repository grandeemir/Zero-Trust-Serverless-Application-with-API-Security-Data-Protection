### VPC ###
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "trr-vpc"
  }
}

### Public Subnets ###

resource "aws_subnet" "public-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr-1
  availability_zone = var.availability_zone-1
  map_public_ip_on_launch = true
  tags = {
    Name = "trr-public-subnet-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr-2
  availability_zone = var.availability_zone-2
  map_public_ip_on_launch = true
  tags = {
    Name = "trr-public-subnet-2"
  }
}

### Private Subnets ###

resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr-1
  availability_zone = var.availability_zone-1
  tags = {
    Name = "trr-private-subnet-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr-2
  availability_zone = var.availability_zone-2
  tags = {
    Name = "trr-private-subnet-2"
  }
}

### Enable ENS Support ###

resource "aws_vpc_enhanced_networking_support" "this" {
  vpc_id = aws_vpc.this.id
  enable = var.enableens_support
}

### Internet Gateway ###

resource "aws_internet_gateway" "trr-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "trr-internet-gateway"
  }
}

### Route Table for Public Subnets ###

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.trr-igw.id
  }

  # you can add more routes here if needed

  tags = {
    Name = "trr-public-route-table"
  }
}

### Associate Public Subnets with Route Table ###

resource "aws_route_table_association" "public-1-assoc" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-2-assoc" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-rt.id
}

### NAT Gateway for Private Subnets ###

resource "aws_eip" "nat-eip-1" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.trr-igw]
}

resource "aws_nat_gateway" "nat-gw-1" {
  allocation_id = aws_eip.nat-eip-1.id
  subnet_id     = aws_subnet.public-1.id
  tags = {
    Name = "trr-nat-gateway-1"
  }
}
  #-------------------------------------------
  # NAT Gateway for second private subnet
  #--------------------------------------------
resource "aws_eip" "nat-eip-2" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.trr-igw]
}

resource "aws_nat_gateway" "nat-gw-2" {
  allocation_id = aws_eip.nat-eip-2.id
  subnet_id     = aws_subnet.public-2.id
  tags = {
    Name = "trr-nat-gateway-2"
  }
}

### Route Table for Private Subnets ###

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-2.id
  }
 
  tags = {
    Name = "trr-private-route-table"
  }
}