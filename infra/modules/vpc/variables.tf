variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_a_cidr" {
  description = "CIDR block for subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  description = "CIDR block for subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_a_az" {
  description = "Availability Zone for subnet A"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_b_az" {
  description = "Availability Zone for subnet B"
  type        = string
  default     = "us-east-1b"
}
