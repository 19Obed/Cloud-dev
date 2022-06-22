#creating aws porovider

resource "aws_vpc" "Rock_on" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Rock_on"
  }
}

#creating public subnet 

resource "aws_subnet" "Rock_on_pub_sub" {
  vpc_id            = aws_vpc.Rock_on.id
  cidr_block        = var.public-sub-cidr
  availability_zone = var.az1

  tags = {
    Name = "Rock_on_pub_sub"
  }
}

resource "aws_subnet" "Rock_on_pub_sub_2" {
  vpc_id            = aws_vpc.Rock_on.id
  cidr_block        = var.public-sub-cidr_2
  availability_zone = var.az2

  tags = {
    Name = "Rock_on_pub_sub_2"
  }
}

#creating public route

resource "aws_route_table" "Rock_on_route_table" {
  vpc_id = aws_vpc.Rock_on.id

  tags = {
    "Name" = "Rock_on_route_table"
  }


}

resource "aws_route_table" "Rock_on_route_table_2" {
  vpc_id = aws_vpc.Rock_on.id

  tags = {
    "Name" = "Rock_on_route_table_2"
  }


}
#associating public subnet to public route 

resource "aws_route_table_association" "rock_on_route_table_associaion" {
  subnet_id      = aws_subnet.Rock_on_pub_sub.id
  route_table_id = aws_route_table.Rock_on_route_table.id
}

#creating internet gateway

resource "aws_internet_gateway" "Rock_on-igw" {
  vpc_id = aws_vpc.Rock_on.id

  tags = {
    Name = "Rock_on-igw"
  }
}

#associating public route table with internet gateway 

resource "aws_route" "Rock_on_route_association" {
  route_table_id         = aws_route_table.Rock_on_route_table.id
  gateway_id             = aws_internet_gateway.Rock_on-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
