#creating RDS MYSQL instance 

#database subnet group
resource "aws_db_subnet_group" "CC_infra_2_db_sub_group" {
  name        = "cc-infra-database_subnets"
  subnet_ids  = [aws_subnet.CC_infra_2_pub_sub.id, aws_subnet.CC_infra_2_priv_sub.id]
  description = "subnet for database instance"


  tags = {
    Name = "CC_infra_db_2_sub_group"
  }
}


#Terraform aws db instance
resource "aws_db_instance" "CC_infra_2_database" {
  allocated_storage      = 12
  engine                 = var.engine
  instance_class         = var.instance_class
  skip_final_snapshot    = true
  parameter_group_name   = var.PGN
  identifier             = var.identifier
  engine_version         = 5.7
  db_subnet_group_name   = aws_db_subnet_group.CC_infra_2_db_sub_group.id
  username               = "myDB"
  password               = "myDBpassword"
  multi_az               = false
  vpc_security_group_ids = [aws_security_group.CC_infra_2_DB_security_group.id]
}