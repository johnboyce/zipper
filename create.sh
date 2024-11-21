#!/bin/zsh

# Create the directory structure
mkdir -p .github/workflows
mkdir -p infra/modules/vpc
mkdir -p infra/modules/api_gateway
mkdir -p infra/modules/elasticache
mkdir -p infra/modules/dynamodb
mkdir -p infra/environments/dev
mkdir -p infra/environments/prod

# Create Terraform provider file
cat <<EOL > infra/provider.tf
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "zipper-tf-state"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
EOL

# Create versions.tf file
cat <<EOL > infra/versions.tf
terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  version = "~> 4.0"
}
EOL

# Create terraform.tfvars file
cat <<EOL > infra/terraform.tfvars
aws_region        = "us-east-1"
vpc_cidr_block    = "10.0.0.0/16"
subnet_a_cidr     = "10.0.1.0/24"
subnet_b_cidr     = "10.0.2.0/24"
subnet_a_az       = "us-east-1a"
subnet_b_az       = "us-east-1b"
api_gateway_name  = "zipper-api"
dynamodb_table    = "zipper-dynamodb"
elasticache_name  = "zipper-redis"
EOL

# Create VPC module files
cat <<EOL > infra/modules/vpc/main.tf
resource "aws_vpc" "zipper_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "zipper-vpc"
  }
}

resource "aws_subnet" "zipper_subnet_a" {
  vpc_id     = aws_vpc.zipper_vpc.id
  cidr_block = var.subnet_a_cidr
  availability_zone = var.subnet_a_az
  map_public_ip_on_launch = true
  tags = {
    Name = "zipper-subnet-a"
  }
}

resource "aws_subnet" "zipper_subnet_b" {
  vpc_id     = aws_vpc.zipper_vpc.id
  cidr_block = var.subnet_b_cidr
  availability_zone = var.subnet_b_az
  map_public_ip_on_launch = true
  tags = {
    Name = "zipper-subnet-b"
  }
}
EOL

# Create VPC variables.tf
cat <<EOL > infra/modules/vpc/variables.tf
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
EOL

# Repeat similar steps for the rest of the modules (api_gateway, elasticache, dynamodb)

echo "Directory and files have been created successfully."
