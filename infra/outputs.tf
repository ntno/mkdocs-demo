output "ci_role_arn" {
  description = "CI IAM Role ARN"
  value       = module.demo_site_cicd.ci_role_info.arn
}

output "cd_role_info" {
  description = "environment name to Map containing CD IAM Role's arn and associated github_environment_name"
  value = {
    for key, val in module.demo_site_cicd.cd_role_info : key => {
      cd_role_arn             = val.arn
      github_environment_name = val.github_environment_name
    }
  }
}

output "artifact_bucket_name" {
  description = "artifact S3 bucket name"
  value       = module.demo_site_cicd.artifacts_bucket_info.id
}

output "development_bucket_name" {
  description = "development S3 bucket name"
  value       = module.dev_site_bucket.site_bucket_info.id
}

output "production_bucket_name" {
  description = "production S3 bucket name"
  value       = module.prod_site_bucket.site_bucket_info.id
}