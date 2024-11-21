variable "elasticache_name" {
  description = "Name for the Redis ElastiCache cluster"
  type        = string
  default     = "zipper-redis"
}

variable "elasticache_azs" {
  description = "List of availability zones for Redis ElastiCache"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
