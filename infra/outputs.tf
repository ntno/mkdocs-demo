output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# output "ci_role_arn" {
#   description = "CI IAM Role ARN"
#   value       = module.demo_site_ci_cd.ci_role_arn
# }

# output "cd_role_arn" {
#   description = "CD IAM Role ARN"
#   value       = module.demo_site_ci_cd.cd_role_arn
# }

output "dev_bucket_name" {
  description = "dev S3 bucket name"
  value       = module.dev_site_bucket.site_bucket_info.id
}

output "prod_bucket_name" {
  description = "prod S3 bucket name"
  value       = module.prod_site_bucket.site_bucket_info.id
}