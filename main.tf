#creating aws porovider

resource "aws_vpc" "CC_infra_2" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "CC_infra_2"
  }
}

#creating public subnet 

resource "aws_subnet" "CC_infra_2_pub_sub" {
  vpc_id            = aws_vpc.CC_infra_2.id
  cidr_block        = var.public-sub-cidr
  availability_zone = var.az1

  tags = {
    Name = "CC_infra_2_pub_sub_2"
  }
}


#creating a private subnet

resource "aws_subnet" "CC_infra_2_priv_sub" {
  vpc_id            = aws_vpc.CC_infra_2.id
  cidr_block        = var.private-sub-cidr
  availability_zone = var.az2

  tags = {
    Name = "CC_infra_2_priv_sub"
  }
}


#creating public route

resource "aws_route_table" "CC_infra_2_route_table" {
  vpc_id = aws_vpc.CC_infra_2.id

  tags = {
    "Name" = "CC_infra_2_route_table"
  }


}

resource "aws_route_table" "CC_infra_2_route_table_2" {
  vpc_id = aws_vpc.CC_infra_2.id

  tags = {
    "Name" = "CC_infra_2_route_table_2"
  }


}
#associating public subnet to public route 

resource "aws_route_table_association" "CC_infra_2_route_table_associaion" {
  subnet_id      = aws_subnet.CC_infra_2_pub_sub.id
  route_table_id = aws_route_table.CC_infra_2_route_table.id
}

#creating internet gateway

resource "aws_internet_gateway" "CC_infra_2-igw" {
  vpc_id = aws_vpc.CC_infra_2.id

  tags = {
    Name = "CC_infra_2-igw"
  }
}

#associating public route table with internet gateway 

resource "aws_route" "CC_infra_2_route_association" {
  route_table_id         = aws_route_table.CC_infra_2_route_table.id
  gateway_id             = aws_internet_gateway.CC_infra_2-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
