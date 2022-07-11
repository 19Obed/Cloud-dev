#creating security group for EC2

resource "aws_security_group" "Rock_consulting_sec_group" {
  name        = "Rock_consulting_sec_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Rock_consulting.id

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
    Name = "Rock_consulting_sec_group"
  }
}

#creating security group for autoscaling group 

resource "aws_security_group" "Rock_cosulting_asg_sec_group" {
  name = "Rock-consulting-asg"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.Rock_consulting_lb_sec_group.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.Rock_consulting_lb_sec_group.id]
  }

  vpc_id = aws_vpc.Rock_consulting.id
}

resource "aws_security_group" "Rock_consulting_lb_sec_group" {
  name = "Rock-consulting-lb"
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

  vpc_id = aws_vpc.Rock_consulting.id
}

#Creating security group for the Database 

resource "aws_security_group" "Rock_DB_security_group" {
  name        = "Rock_DB_security_group"
  description = "Enable MYSQL access on port 3306"
  vpc_id      = aws_vpc.Rock_consulting.id

  ingress {
    description = "MYSQL Access"
    from_port   = 3306
    to_port     = 3306
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
    Name = "Rock_DB_security_group"
  }
}