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
