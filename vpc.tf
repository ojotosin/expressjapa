# creates the vpc
resource "aws_vpc" "vpc" {
  cidr_block                = var.dev_vpc_cidr
  instance_tenancy          = "default"
  enable_dns_hostnames      = true

  tags                      = {
    Name                    = "dev-vpc"
  }
}

# creates the internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id                    = aws_vpc.vpc.id

  tags                      = {
    Name                    = "dev-igw"
  }
}

# creates public subnet in az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.public_subnet_az1_cidr
  availability_zone         = "us-east-1a"
  map_public_ip_on_launch   = true
  tags                      = {
    Name                    = "public-subnet-az1"
  }
} 

# creates public subnet in az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.public_subnet_az2_cidr
  availability_zone         = "us-east-1b"
  map_public_ip_on_launch   = true

  tags                      = {
    Name                    = "public-subnet-az2"
  }
}

# creates route table
resource "aws_route_table" "public_route_table" {
  vpc_id                    = aws_vpc.vpc.id

  route {
    cidr_block              = var.public_rtb_cidr
    gateway_id              = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rtb"
  }
}

# associates public subnet az1 with public route table
resource "aws_route_table_association" "az1" {
  subnet_id                 = aws_subnet.public_subnet_az1.id
  route_table_id            = aws_route_table.public_route_table.id
}

# associates public subnet az2 with public route table
resource "aws_route_table_association" "az2" {
  subnet_id                 = aws_subnet.public_subnet_az2.id
  route_table_id            = aws_route_table.public_route_table.id
}

# creates private app subnet in az1
resource "aws_subnet" "private_appsubnet_az1" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_appsubnet_az1_cidr
  availability_zone         = "us-east-1a"
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private-appsubnet-az1"
  }
}

# creates private app subnet in az2
resource "aws_subnet" "private_appsubnet_az2" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_appsubnet_az2_cidr
  availability_zone         = "us-east-1b"
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private-appsubnet-az2"
  }
}

# creates private data subnet in az1
resource "aws_subnet" "private_datasubnet_az1" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_datasubnet_az1_cidr
  availability_zone         = "us-east-1a"
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private-datasubnet-az1"
  }
}

# creates private data subnet in az2
resource "aws_subnet" "private_datasubnet_az2" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_datasubnet_az2_cidr
  availability_zone         = "us-east-1b"
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private-datasubnet-az2"
  }
}