# 1. DB Subnet Group (Crucial for keeping DBs in private subnets)
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "${var.environment}-db-subnet-group" }
}

# 2. PostgreSQL RDS Instance
resource "aws_db_instance" "postgres" {
  identifier           = "${var.environment}-postgres"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro" # Free Tier eligible
  db_name              = "eswapdb"
  username             = "postgres"
  password             = "ChangeMe123!" # In prod, use Secrets Manager!
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]
}

# 3. Redis ElastiCache (For fast session storage)
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.environment}-redis-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.environment}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [var.db_security_group_id]
}