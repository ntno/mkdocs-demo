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

resource "random_pet" "site_name" {
  length = 3
}

module "production_site_bucket" {
  source      = "./modules/simple-site-bucket"
  bucket_name = local.site_name
  tags = merge(local.global_tags, {
    project-environment = "production"
  })
}

module "development_site_bucket" {
  source      = "./modules/simple-site-bucket"
  bucket_name = local.dev_site_name
  tags = merge(local.global_tags, {
    project-environment = "development"
  })
}

locals {
  site_name            = var.site_bucket_name == "" ? random_pet.site_name.id : var.site_bucket_name
  dev_site_name        = format("%s-development", local.site_name)
  artifact_bucket_name = format("%s-artifacts", local.site_name)
  global_tags = {
    CreatedBy   = "mkdocs-demo"
    Provisioner = "Terraform"
    project     = "mkdocs-demo"
    domain      = "personal"
  }
}

module "demo_site_cicd" {
  source               = "git::https://github.com/ntno/tf-module-static-site-cicd?ref=refactor-for-multiple-deployment-environments"
  artifact_bucket_name = local.artifact_bucket_name
  ci_prefix            = format("%s-%s-ci-pr-", var.github_org, var.github_repo)

  github_repo = var.github_repo
  github_org  = var.github_org
  tags        = local.global_tags

  deployment_environments = {
    "production" = {
      github_environment_name = "prod"
      deploy_bucket           = local.site_name
      tags = {
        project-environment = "production"
      }
    },
    "development" = {
      github_environment_name = "ci"
      deploy_bucket           = local.dev_site_name
      tags = {
        project-environment = "development"
      }
    }
  }
}