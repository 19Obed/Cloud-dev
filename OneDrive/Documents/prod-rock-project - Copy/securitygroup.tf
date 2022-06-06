#creating security group

resource "aws_security_group" "prod-rock-sec-group" {
  name        = "prod-rock-sec-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod-rock-VPC.id

  ingress {
    description = "security group with ingress HTTP port opened "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {
    description = "security group with ingress SSH port opened "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}