terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "eswap-au-tfstate-1776745154" #Bucket name form Remote State
    key            = "dev/networking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eswap-au-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}