terraform {
  required_version = ">= 1.0"

  backend "s3" {
    region = "eusc-de-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.48.0"
    }
  }
}
