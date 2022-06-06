#creating a server for eu-west-2 region in public subnet

resource "aws_instance" "Test-server-1" {
  ami                         = var.ami_version_1
  instance_type               = var.instance_type_1
  key_name                    = var.Kn1
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.prod-rock-sec-group.id]
  subnet_id                   = aws_subnet.prod-rock-sub1.id
  iam_instance_profile        = aws_iam_instance_profile.Prod_role.id




  tags = {
    Name = "Test-server-1"
  }
}

#creating a server for eu-west-2 region in private subnet

resource "aws_instance" "Test-server-2" {
  ami                         = var.ami_version_2
  instance_type               = var.instance_type_2
  key_name                    = var.Kn2
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.prod-rock-sec-group.id]
  subnet_id                   = aws_subnet.prod-rock-priv-sub.id
  iam_instance_profile        = aws_iam_instance_profile.Prod_role.id



  tags = {
    Name = "Test-server-2"
  }
}



