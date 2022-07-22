#creating EC2 instance in public subnet

resource "aws_instance" "CC_infra_EC2" {
  ami                         = var.ami_version
  instance_type               = var.instance_type
  key_name                    = var.Key-name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.CC_infra_sec_group.id]
  subnet_id                   = aws_subnet.CC_infra_pub_sub.id 

  tags = {
    Name = "CC_infra_EC2"
  }
}