resource "aws_elasticache_cluster" "zipper_redis" {
  cluster_id           = var.elasticache_name
  engine               = "redis"
  node_type            = "cache.t3.micro"
  number_of_nodes     = 1
  parameter_group_name = "default.redis6.x"
  port                 = 6379
  availability_zones   = var.elasticache_azs
  subnet_group_name    = aws_elasticache_subnet_group.zipper.name
}

resource "aws_elasticache_subnet_group" "zipper" {
  name       = "zipper-redis-subnet-group"
  subnet_ids = [aws_subnet.zipper_subnet_a.id, aws_subnet.zipper_subnet_b.id]
}

resource "aws_security_group" "zipper_redis_sg" {
  name_prefix = "zipper-redis-sg"
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
