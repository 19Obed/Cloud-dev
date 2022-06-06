#creating AWS network for project 

resource "aws_vpc" "prod-rock-VPC" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "prod-rock-VPC"
  }
}

#Test-pub-sub1

resource "aws_subnet" "prod-rock-sub1" {
  vpc_id            = aws_vpc.prod-rock-VPC.id
  cidr_block        = var.public-sub-cidr
  availability_zone = var.az1

  tags = {
    Name = "prod-rock-sub2"
  }
}

#Test-pub-sub2

resource "aws_subnet" "prod-rock-sub2" {
  vpc_id            = aws_vpc.prod-rock-VPC.id
  cidr_block        = var.public-sub-cidr_2
  availability_zone = var.az2

  tags = {
    Name = "prod-rock-sub2"
  }
}

#Test-priv-sub-table

resource "aws_subnet" "prod-rock-priv-sub" {
  vpc_id            = aws_vpc.prod-rock-VPC.id
  cidr_block        = var.private-sub-cidr
  availability_zone = var.az3

  tags = {
    Name = "prod-rock-priv-sub"
  }
}

#Test-priv-sub-table2

resource "aws_subnet" "prod-rock-priv-sub2" {
  vpc_id            = aws_vpc.prod-rock-VPC.id
  cidr_block        = var.private-sub-cidr_2
  availability_zone = var.az4
  tags = {
    Name = "prod-rock-priv-sub2"
  }
}

#Test-pub-route-table

resource "aws_route_table" "prod-rock-route-table" {
  vpc_id = aws_vpc.prod-rock-VPC.id

  tags = {
    Name = "prod-rod-route-table "
  }
}

#Test-priv-route-table

resource "aws_route_table" "prod-rock-priv-route-table" {
  vpc_id = aws_vpc.prod-rock-VPC.id

  tags = {
    Name = "prod-rod-priv-route-table"
  }
}

#Associating public subnets to prublic route tables 

resource "aws_route_table_association" "prod-rock-route-association" {
  subnet_id      = aws_subnet.prod-rock-sub1.id
  route_table_id = aws_route_table.prod-rock-priv-route-table.id
}

#Associating private subnet to private route tables

resource "aws_route_table_association" "prod-rock-private-route-association" {
  subnet_id      = aws_subnet.prod-rock-priv-sub.id
  route_table_id = aws_route_table.prod-rock-priv-route-table.id
}


#creating internet gateway 

resource "aws_internet_gateway" "prod-rock-igw" {
  vpc_id = aws_vpc.prod-rock-VPC.id

  tags = {
    Name = "prod-rock-igw"
  }
}

#Associating internet gateway with the public route table 

resource "aws_route" "igw-associaton" {
  route_table_id         = aws_route_table.prod-rock-priv-route-table.id
  gateway_id             = aws_internet_gateway.prod-rock-igw.id
  destination_cidr_block = "0.0.0.0/0"

}

#creating elastic ip

resource "aws_eip" "prod-rock-eip" {
  vpc = true

  tags = {
    Name = "prod-rock-eip"
  }
}

#creating NAT gateway 

resource "aws_nat_gateway" "prod-rock-NAT-gateway" {
  allocation_id = aws_eip.prod-rock-eip.id
  subnet_id     = aws_subnet.prod-rock-priv-sub.id



  tags = {
    Name = "prod-rock-NAT-gateway"
  }
}
