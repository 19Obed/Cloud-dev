#creating aws porovider

resource "aws_vpc" "Rock_consulting" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Rock_consulting"
  }
}

#creating public subnet 

resource "aws_subnet" "Rock_consulting_pub_sub" {
  vpc_id            = aws_vpc.Rock_consulting.id
  cidr_block        = var.public-sub-cidr
  availability_zone = var.az1

  tags = {
    Name = "Rock_consulting_pub_sub"
  }
}

resource "aws_subnet" "Rock_consulting_pub_sub_2" {
  vpc_id            = aws_vpc.Rock_consulting.id
  cidr_block        = var.public-sub-cidr_2
  availability_zone = var.az2

  tags = {
    Name = "Rock_consulting_pub_sub_2"
  }
}

resource "aws_subnet" "Rock_consulting_pub_sub_3" {
  vpc_id            = aws_vpc.Rock_consulting.id
  cidr_block        = var.public-sub-cidr_3
  availability_zone = var.az3

  tags = {
    Name = "Rock_consulting_pub_sub_3"
  }
}
#creating public route

resource "aws_route_table" "Rock_consulting_route_table" {
  vpc_id = aws_vpc.Rock_consulting.id

  tags = {
    "Name" = "Rock_consulting_route_table"
  }


}

resource "aws_route_table" "Rock_consulting_route_table_2" {
  vpc_id = aws_vpc.Rock_consulting.id

  tags = {
    "Name" = "Rock_consulting_route_table_2"
  }


}

resource "aws_route_table" "Rock_consulting_route_table_3" {
  vpc_id = aws_vpc.Rock_consulting.id

  tags = {
    "Name" = "Rock_consulting_route_table_3"
  }


}
#associating public subnet to public route 

resource "aws_route_table_association" "rock_consulting_route_table_associaion" {
  subnet_id      = aws_subnet.Rock_consulting_pub_sub.id
  route_table_id = aws_route_table.Rock_consulting_route_table.id
}

#associating public route table with internet gateway 

resource "aws_route" "Rock_consulting_route_association" {
  route_table_id         = aws_route_table.Rock_consulting_route_table.id
  gateway_id             = aws_internet_gateway.Rock_consulting_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

#creating internet gateway

resource "aws_internet_gateway" "Rock_consulting_igw" {
  vpc_id = aws_vpc.Rock_consulting.id

  tags = {
    Name = "Rock_consulting_igw"
  }
}

