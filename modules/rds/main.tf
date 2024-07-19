# Fetch existing secrets for the User DB
data "aws_secretsmanager_secret" "db_user" {
  name = "secret-rds-user-db"
}

data "aws_secretsmanager_secret_version" "db_user_secret" {
  secret_id = data.aws_secretsmanager_secret.db_user.id
}

# Fetch existing secrets for the Product DB
data "aws_secretsmanager_secret" "db_product" {
  name = "secret-rds-product-db"
}

data "aws_secretsmanager_secret_version" "db_product_secret" {
  secret_id = data.aws_secretsmanager_secret.db_product.id
}

# Fetch existing secrets for the Inventory DB
data "aws_secretsmanager_secret" "db_inventory" {
  name = "rds-inventory-db-secret"
}

data "aws_secretsmanager_secret_version" "db_inventory_secret" {
  secret_id = data.aws_secretsmanager_secret.db_inventory.id
}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "user_db" {
  identifier             = "user-db-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.25"
  instance_class         = "db.t3.micro"
  db_name                = "userdb"
  username               = jsondecode(data.aws_secretsmanager_secret_version.db_user_secret.secret_string)["username"]
  password               = replace(replace(jsondecode(data.aws_secretsmanager_secret_version.db_user_secret.secret_string)["password"], "/", ""), "@", "")
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
}

resource "aws_db_instance" "product_db" {
  identifier             = "product-db-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.25"
  instance_class         = "db.t3.micro"
  db_name                = "productdb"
  username               = jsondecode(data.aws_secretsmanager_secret_version.db_product_secret.secret_string)["username"]
  password               = replace(replace(jsondecode(data.aws_secretsmanager_secret_version.db_product_secret.secret_string)["password"], "/", ""), "@", "")
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
}

resource "aws_db_instance" "inventory_db" {
  identifier             = "inventory-db-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.25"
  instance_class         = "db.t3.micro"
  db_name                = "inventorydb"
  username               = jsondecode(data.aws_secretsmanager_secret_version.db_inventory_secret.secret_string)["username"]
  password               = replace(replace(jsondecode(data.aws_secretsmanager_secret_version.db_inventory_secret.secret_string)["password"], "/", ""), "@", "")
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
}

output "user_instance_endpoint" {
  description = "The endpoint of the RDS instance for User Service"
  value       = aws_db_instance.user_db.endpoint
}

output "product_instance_endpoint" {
  description = "The endpoint of the RDS instance for Product Service"
  value       = aws_db_instance.product_db.endpoint
}

output "inventory_instance_endpoint" {
  description = "The endpoint of the RDS instance for Inventory Service"
  value       = aws_db_instance.inventory_db.endpoint
}
