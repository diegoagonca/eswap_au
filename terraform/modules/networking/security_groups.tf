resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Allow internal traffic to PostgreSQL and Redis"
  vpc_id      = aws_vpc.main.id

  # PostgreSQL Ingress (Port 5432)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block] # Only allow traffic from inside the VPC
  }

  # Redis Ingress (Port 6379)
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}