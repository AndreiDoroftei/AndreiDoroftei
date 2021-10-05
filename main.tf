terraform {
  backend "remote" {
    organization = "doroftei1999"
    workspaces {
      name = "cloudfront-aws"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "cloudflare" {
  email   = data.aws_ssm_parameter.cloudflare_email.value
  api_key = data.aws_ssm_parameter.cloudflare_api_key.value
}



