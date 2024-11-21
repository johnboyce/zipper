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
