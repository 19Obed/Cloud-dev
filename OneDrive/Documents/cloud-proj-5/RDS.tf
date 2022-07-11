#creating RDS MYSQL instance 

#database subnet group
resource "aws_db_subnet_group" "rock_consulting_db_sub_group" {
  name        = "rock_consulting_database_subnets"
  subnet_ids  = [aws_subnet.Rock_consulting_pub_sub.id, aws_subnet.Rock_consulting_pub_sub_2.id]
  description = "subnet for database instance"


  tags = {
    Name = "rock_consulting_db_sub_group"
  }
}

#Terraform aws data db snapshot
data "aws_db_snapshot" "Rock_consulting_db_snapshot" {
  db_snapshot_identifier = var.snapshot_identifier
  most_recent            = true
  snapshot_type          = "manual"
}


#Terraform aws db instance
resource "aws_db_instance" "rock_consulting_database" {
  allocated_storage      = 10
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  skip_final_snapshot    = true
  availability_zone      = "eu-west-2a"
  identifier             = "rc-database"
  snapshot_identifier    = data.aws_db_snapshot.Rock_consulting_db_snapshot.id
  db_subnet_group_name   = aws_db_subnet_group.rock_consulting_db_sub_group.id
  multi_az               = false
  vpc_security_group_ids = [aws_security_group.Rock_DB_security_group.id]
}