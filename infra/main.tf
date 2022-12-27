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
  ci_prefix            = format("%s-ci-pr-", local.site_name)
  artifact_bucket_name = format("%s-artifacts", local.site_name)
}

resource "random_pet" "site_name" {
  length = 3
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

module "demo_site_cicd" {
  source               = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=refactor-for-multiple-deployment-environments"
  artifact_bucket_name = local.artifact_bucket_name
  ci_prefix            = local.ci_prefix

  github_repo = "mkdocs-demo"
  github_org  = "ntno"
  tags        = local.global_tags
}