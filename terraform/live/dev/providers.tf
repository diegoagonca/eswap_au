terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "INSERT_YOUR_BUCKET_NAME_HERE"
    key            = "dev/networking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eswap-au-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}