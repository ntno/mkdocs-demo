output "ci_role_arn" {
  description = "CI IAM Role ARN"
  value       = module.demo_site_cicd.ci_role_info.arn
}

# output "cd_role_arn" {
#   description = "CD IAM Role ARN"
#   value       = module.demo_site_ci_cd.cd_role_arn
# }

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