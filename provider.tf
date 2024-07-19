terraform {
  backend "s3" {
    bucket         = "samo-assesment"
    key            = "samo-assessment/terraform/remote/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "dynamodb-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0.0"
}

# Provider configuration
provider "aws" {
  region = "us-east-2"
}
