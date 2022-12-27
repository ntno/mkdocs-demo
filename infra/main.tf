terraform {
  backend "s3" {
    encrypt = true
    key     = "mkdocs-demo.tfstate"
  }
}

provider "random" {}

provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  site_name     = var.site_bucket_name == "" ? random_pet.site_name.id : var.site_bucket_name
  dev_site_name = format("dev.%s", local.site_name)
  global_tags = {
    CreatedBy   = "mkdocs-demo"
    Provisioner = "Terraform"
    project     = "mkdocs-demo"
    domain      = "personal"
  }
}

module "prod_site_bucket" {
  source      = "./modules/simple-site-bucket"
  bucket_name = local.site_name
  tags        = local.global_tags
}

module "dev_site_bucket" {
  source      = "./modules/simple-site-bucket"
  bucket_name = local.dev_site_name
  tags        = local.global_tags
}
