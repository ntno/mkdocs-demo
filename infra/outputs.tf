output "ci_role_info" {
  description = "environment ID to map containing CI IAM Role ARN, prefix restriction, and github_environment_name"
  value = {
    for key, val in module.demo_site_cicd.ci_role_info : key => {
      ci_role_arn             = val.arn
      ci_prefix               = val.ci_prefix
      github_environment_name = val.github_environment_name
    }
  }
}

output "cd_role_info" {
  description = "environment ID to map containing CD IAM Role's arn and associated github_environment_name"
  value = {
    for key, val in module.demo_site_cicd.cd_role_info : key => {
      cd_role_arn             = val.arn
      github_environment_name = val.github_environment_name
    }
  }
}

output "artifact_bucket_info" {
  description = "artifact S3 bucket name"
  value = {
    name = module.demo_site_cicd.artifacts_bucket_info.id
  }
}

output "development_bucket_info" {
  description = "development site bucket name and website endpoint"
  value = {
    name             = module.development_site_bucket.site_bucket_info.id
    website_endpoint = module.development_site_bucket.site_bucket_info.website_endpoint
  }
}

output "production_bucket_info" {
  description = "production site bucket name and website endpoint"
  value = {
    name             = module.production_site_bucket.site_bucket_info.id
    website_endpoint = module.production_site_bucket.site_bucket_info.website_endpoint
  }
}