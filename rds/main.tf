# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.database_subnet_group
  multi_az             = false
  vpc_security_group_ids = [var.database_security_group_id]
  identifier             = "dev-rds-db"

  availability_zone = var.availability_zone_1

    tags = {
    Name = "${var.project_name}-${var.environment}-rds"
  }
}