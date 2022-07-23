#creating security group for EC2

resource "aws_security_group" "CC_infra_sec_group" {
  name        = "CC_infra_sec_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.CC_infra.id

  ingress {
    description = "security group with ingress SSH port opened"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "security group with ingress HTTP port opened"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "CC_infra_sec_group"
  }
}

#creating security group for autoscaling group 

resource "aws_security_group" "CC_infra_asg_sec_group" {
  name = "CC-on-asg"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.CC_infra_lb_sec_group.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.CC_infra_lb_sec_group.id]
  }

  vpc_id = aws_vpc.CC_infra.id
}

resource "aws_security_group" "CC_infra_lb_sec_group" {
  name = "CC-on-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.CC_infra.id
}
