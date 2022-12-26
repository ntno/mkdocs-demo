output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "ci_role_arn" {
  description = "CI IAM Role ARN"
  value       = module.demo_site_ci_cd.ci_role_arn
}

output "cd_role_arn" {
  description = "CD IAM Role ARN"
  value       = module.demo_site_ci_cd.cd_role_arn
}

output "site_bucket_info" {
  description = "Map containing the site bucket's arn, id, and website endpoint"
  value = {
    "arn"              = aws_s3_bucket.site_bucket.arn
    "id"               = aws_s3_bucket.site_bucket.id
    "website_endpoint" = aws_s3_bucket_website_configuration.site_bucket_website_configuration.website_endpoint
  }
}