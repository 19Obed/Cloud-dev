#creating EC2 instance in public subnet

resource "aws_instance" "Rock_on_EC2" {
  ami                         = var.ami_version
  instance_type               = var.instance_type
  key_name                    = var.Key-name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Rock_on_sec_group.id]
  subnet_id                   = aws_subnet.Rock_on_pub_sub.id

  tags = {
    Name = "Rock_on_EC2"
  }
}