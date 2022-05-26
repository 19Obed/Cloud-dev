#creating aws network for project 

resource "aws_vpc" "Cloud_engine" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "cloud_engine"
  }
}

#public subnet 
resource "aws_subnet" "cloud_subnet" {
  vpc_id            = aws_vpc.Cloud_engine.id
  cidr_block        = var.public-cidr
  availability_zone = var.az1

  tags = {
    Name = "cloud_engine"
  }
}

resource "aws_subnet" "cloud_subnet_2" {
  vpc_id            = aws_vpc.Cloud_engine.id
  cidr_block        = var.public-cidr_2
  availability_zone = var.az2

  tags = {
    Name = "cloud_engine_2"
  }
}

resource "aws_subnet" "cloud_subnet_3" {
  vpc_id            = aws_vpc.Cloud_engine.id
  cidr_block        = var.public-cidr_3
  availability_zone = var.az3

  tags = {
    Name = "cloud_engine_3"
  }
}

#private subnet 
resource "aws_subnet" "cloud_private_subnet" {
  vpc_id            = aws_vpc.Cloud_engine.id
  cidr_block        = var.private-cidr
  availability_zone = var.az4

  tags = {
    Name = "cloud_private_subnet"
  }
}

resource "aws_subnet" "cloud_private_subnet_2" {
  vpc_id            = aws_vpc.Cloud_engine.id
  cidr_block        = var.private-cidr_2
  availability_zone = var.az5

  tags = {
    Name = "cloud_private_subnet_2"
  }
}

#public route table
resource "aws_route_table" "cloud_route_table" {
  vpc_id = aws_vpc.Cloud_engine.id


  tags = {
    Name = "cloud_route_table"
  }
}

#private route table
resource "aws_route_table" "cloud_private_route_table" {
  vpc_id = aws_vpc.Cloud_engine.id


  tags = {
    Name = "cloud_private_route_table"
  }
}

#associate public subnet with the public route table
resource "aws_route_table_association" "cloud_route_table_association" {
  subnet_id      = aws_subnet.cloud_subnet.id
  route_table_id = aws_route_table.cloud_route_table.id
}

#associate private sunet with private route table
resource "aws_route_table_association" "cloud_private_route_table_association" {
  subnet_id      = aws_subnet.cloud_private_subnet.id
  route_table_id = aws_route_table.cloud_private_route_table.id
}

#internet gateway
resource "aws_internet_gateway" "cloud_IGW" {
  vpc_id = aws_vpc.Cloud_engine.id

  tags = {
    Name = "cloud_IGW"
  }
}

#associate internet gateway to the public route table 
resource "aws_route" "cloud_IGW_association" {
  route_table_id         = aws_route_table.cloud_route_table.id
  gateway_id             = aws_internet_gateway.cloud_IGW.id
  destination_cidr_block = "0.0.0.0/0"
}