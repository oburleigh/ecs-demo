terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.2"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.1"
    }
  }
}
